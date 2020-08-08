import UIKit
import Flutter
import Foundation
import HealthKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

        //health channel
        let healthChannel = FlutterMethodChannel(name: "com.h2uclub.hi365/health",binaryMessenger: controller.binaryMessenger)

        // Start: Zoom Channel
        let zoomChannel = FlutterMethodChannel(
            name: "com.h2uclub.hi365/join_meeting",
            binaryMessenger: controller.binaryMessenger)
        let mbhChannel = FlutterMethodChannel(name:  ChannelName.channel,
                                              binaryMessenger: controller.binaryMessenger)

        //Start: Health kit
        healthChannel.setMethodCallHandler(handle);
        //End: Health kit

        // Init Zoom SDK
        let zoom = Zoom()

        zoomChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            zoomChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: FlutterResult) -> Void in
                guard call.method == "joinMeeting" else {
                    result(FlutterMethodNotImplemented)
                    return
                }

                let id:String = call.arguments as! String
                zoom.joinMeeting(id)
            })
        })
        // End: Zoom Channel

        //mhb
        let mhb = CustomMHB(controller)
        mbhChannel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "getMHBoperation" || call.method == "checkMHBFiles" else {
                result(FlutterMethodNotImplemented)
                return
            }
            if (call.method == "getMHBoperation"){
                mhb.getMHBoperation()
            } else if (call.method == "checkMHBFiles"){
                mhb.checkMHBFiles(result: result)
            }
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    //Start: Health kit
    var healthStore: HKHealthStore? = nil;
    var TAG = "health kit";

    public func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard HKHealthStore.isHealthDataAvailable() else {
            result(FlutterError(code: TAG, message: "Not supported", details: nil))
            return
        }

        if (call.method == "requestPermissions") {
            do {
                let request = try PermissionsRequest.fromCall(call: call)
                requestPermissions(request: request, result: result)
            } catch {
                result(FlutterError(code: TAG, message: "Error \(error)", details: nil))
            }
        } else if (call.method == "read") {
            do {
                let request = try ReadRequest.fromCall(call: call)
                read(request: request, result: result)
            } catch {
                result(FlutterError(code: TAG, message: "Error \(error)", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    private func requestPermissions(request: PermissionsRequest, result: @escaping FlutterResult) {
        requestAuthorization(sampleTypes: request.sampleTypes) { success, error in
            guard success else {
                result(false)
                return
            }

            result(true)
        }
    }

    private func read(request: ReadRequest, result: @escaping FlutterResult) {
        requestAuthorization(sampleTypes: [request.sampleType]) { success, error in
            guard success else {
                result(error)
                return
            }

            self.readSample(request: request, result: result)
        }
    }

    private func requestAuthorization(sampleTypes: Array<HKSampleType>, completion: @escaping (Bool, FlutterError?) -> Void) {
        if (healthStore == nil) {
            healthStore = HKHealthStore();
        }

        healthStore!.requestAuthorization(toShare: nil, read: Set(sampleTypes)) { (success, error) in
            guard success else {
                completion(false, FlutterError(code: self.TAG, message: "Error \(error?.localizedDescription ?? "empty")", details: nil))
                return
            }

            completion(true, nil)
        }
    }

    private func readSample(request: ReadRequest, result: @escaping FlutterResult) {

        let predicate = HKQuery.predicateForSamples(withStart: request.dateFrom, end: request.dateTo, options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)

        let query = HKSampleQuery(sampleType: request.sampleType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) {
            _, samplesOrNil, error in
            //HKQuantitySample //HKCategorySample
            guard let samples = samplesOrNil else {
                result(FlutterError(code: self.TAG, message: "Results are null", details: error))
                return
            }

            if let quantitySample = samples as? [HKQuantitySample] {
                result(quantitySample.map { sample -> NSDictionary in
                    return [
                        "value": sample.quantity.doubleValue(for: request.unit),
                        "date_from": Int(sample.startDate.timeIntervalSince1970 * 1000),
                        "date_to": Int(sample.endDate.timeIntervalSince1970 * 1000),
                    ]
                })
            }else if let categorySamples = samples as? [HKCategorySample] {
                result(categorySamples.map { sample -> NSDictionary in
                    return [
                        "value": sample.value,
                        "date_from": Int(sample.startDate.timeIntervalSince1970 * 1000),
                        "date_to": Int(sample.endDate.timeIntervalSince1970 * 1000),
                    ]
                })
            } else {
                result(FlutterError(code: self.TAG, message: "Unknown HKSample Type \(type(of: samples))", details: error))
            }
        }
        healthStore!.execute(query)
    }
    //End: Health kit

    private func getReturnMessageObj(methodName: String, statusCode: String, details: String, fileName:String?=nil) -> [String: String] {
        var returnDataMap = [String: String]()
        returnDataMap["methodName"] = methodName
        returnDataMap["code"] =  statusCode
        returnDataMap["content"] = details
        if fileName != nil {
            returnDataMap["fileName"] = fileName
        }
        return returnDataMap;
    }

   
}

//Start: Health kit
class PermissionsRequest {
    let types: Array<String>
    let sampleTypes: Array<HKSampleType>

    private init(types: Array<String>, sampleTypes: Array<HKSampleType>) {
        self.types = types;
        self.sampleTypes = sampleTypes
    }

    static func fromCall(call: FlutterMethodCall) throws -> PermissionsRequest {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let types = arguments["types"] as? Array<String> else {
                throw "invalid call arguments \(String(describing: call.arguments))";
        }

        let sampleTypes = try types.map { type -> HKSampleType in
            try HKSampleType.fromDartType(type: type)
        }

        return PermissionsRequest(types: types, sampleTypes: sampleTypes)
    }
}

class ReadRequest {
    let type: String
    let sampleType: HKSampleType
    let unit: HKUnit

    let dateFrom: Date
    let dateTo: Date

    private init(type: String, sampleType: HKSampleType, unit: HKUnit, dateFrom: Date, dateTo: Date) {
        self.type = type;
        self.sampleType = sampleType
        self.unit = unit
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }

    static func fromCall(call: FlutterMethodCall) throws -> ReadRequest {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
            let type = arguments["type"] as? String,
            let dateFromEpoch = arguments["date_from"] as? NSNumber,
            let dateToEpoch = arguments["date_to"] as? NSNumber else {
                throw "invalid call arguments \(String(describing: call.arguments))";
        }

        let sampleType = try HKSampleType.fromDartType(type: type)
        let unit = try HKUnit.fromDartType(type: type)
        let dateFrom = Date(timeIntervalSince1970: dateFromEpoch.doubleValue / 1000)
        let dateTo = Date(timeIntervalSince1970: dateToEpoch.doubleValue / 1000)


        return ReadRequest(type: type, sampleType: sampleType, unit: unit, dateFrom: dateFrom, dateTo: dateTo)
    }
}

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}

extension HKSampleType {
    public static func fromDartType(type: String) throws -> HKSampleType {
        guard let sampleType: HKSampleType = {
            switch type {
            case "heart_rate":
                return HKSampleType.quantityType(forIdentifier: .heartRate)
            case "step_count":
                return HKSampleType.quantityType(forIdentifier: .stepCount)
            case "height":
                return HKSampleType.quantityType(forIdentifier: .height)
            case "weight":
                return HKSampleType.quantityType(forIdentifier: .bodyMass)
            case "distance":
                return HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)
            case "energy":
                return HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)
            case "blood_systolic":
                return HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)
            case "blood_diastolic":
                return HKSampleType.quantityType(forIdentifier: .bloodPressureDiastolic)
            case "sleep":
                return HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)
            default:
                return nil
            }
            }() else {
                throw "type \"\(type)\" is not supported";
        }
        return sampleType
    }
}

extension HKUnit {
    public static func fromDartType(type: String) throws -> HKUnit {
        guard let unit: HKUnit = {
            switch (type) {
            case "heart_rate":
                return HKUnit.init(from: "count/min")
            case "step_count":
                return HKUnit.count()
            case "height":
                return HKUnit.meter()
            case "weight":
                return HKUnit.gramUnit(with: .kilo)
            case "distance":
                return HKUnit.meter()
            case "energy":
                return HKUnit.kilocalorie()
            case "blood_systolic":
                return HKUnit.millimeterOfMercury()
            case "blood_diastolic":
                return HKUnit.millimeterOfMercury()
            case "sleep":
                return HKUnit.hour()
            default:
                return nil
            }
            }() else {
                throw "type \"\(type)\" unit is not supported";
        }
        return unit
    }
}
//End: Health kit
