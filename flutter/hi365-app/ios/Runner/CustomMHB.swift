//
//  CustomMHB.swift
//  Runner
//
//  Created by waltor on 2020/1/17.
//
//import UIKit //need to use window
//import Foundation
//import Zip
//#if arch(i386) || arch(x86_64)
//#else
//import MHBSdk
//#endif

enum MHBResult:Error {
    case configProblem
}

enum ChannelName {
    static let channel = "com.h2uclub.hi365/mhb"
}

enum MHBErrorCode {
    static let unexpectedError = "097"
    static let dataprocessError = "095"
    static let noNetworkError = "098"
    static let systembusy = "099"
    static let noemulator = "096"
}

class CustomMHB : MHBDelegate{
    let controller : FlutterViewController
    init(_ controller:FlutterViewController){
        self.controller = controller;
    }
    
    func didStartProcSuccess() {
        //todo:
        NSLog("didStartProcSuccess")
    }
    
    func didStartProcFailure(error: String) {
        //todo:
        NSLog("Start process failure: \(error)")
    }
    
    func didFetchDataSuccess(file: Data, serverKey: String) {
        autoreleasepool {
            let password = getFilePassword(password: infoForKey("MHB_API_KEY")!, salt: serverKey)
            if( password != "") {
                _ = openMHBFile(data: file, password: password);
                NSLog("=== didFetchDataSuccess: didFetchDataSuccess ")
                let flutterError =  buildMHBStatusCode(code: "200")
                let alertController = UIAlertController(title: flutterError["message"], message: "" , preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(confirmAction)
                presentAlert(alertController)
            } else {
                NSLog("=== didFetchDataSuccess: Wrong Password ")
                didStartProcFalure(error: "102")
            }
        }
    }
    
    func didFetchDataFailure(error: String) {
        NSLog("=== didFetchDataFailure: \(error)")
        if error != "202" {
            let flutterError =  buildMHBStatusCode(code: error)
            let alertController = UIAlertController(title: flutterError["message"], message: "", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(confirmAction)
            presentAlert(alertController)
        }
    }
    
    func didMHBExit() {
        NSLog("MHB Exit!")
    }
    
    // --------  below method is implementation of MHBdelegate ---------
    
    var isMHBConfigured = false
    
    //generating key with new way.
    func getFilePassword(password: String, salt: String) -> String {
        let hash = CCPBKDFAlgorithm(kCCPRFHmacAlgSHA1)
        let rounds = 1000
        let passwordData = password.data(using: .utf8)!
        let saltData = salt.data(using: .utf8)!
        var derivedKeyData = Data(repeating: 0, count: 32)
        let localDerivedKeyData = derivedKeyData
        
        let derivationStatus = derivedKeyData.withUnsafeMutableBytes { derivedKeyBytes in
            saltData.withUnsafeBytes { saltBytes in
                
                CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    password, passwordData.count,
                    saltBytes, saltData.count,
                    hash,
                    UInt32(rounds),
                    derivedKeyBytes, localDerivedKeyData.count)
            }
        }
        if (derivationStatus != kCCSuccess) {
            NSLog("=== getFilePasswordFailure ===")
            return "";
        }
        
        return derivedKeyData.base64EncodedString()
    }
    
    //get api key value from Runner->build-setting->user-defined
    func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
    
    //open MHB file, need user password.
    func openMHBFile(data: Data, password: String) -> String {
        let tempDir = URL(fileURLWithPath: NSTemporaryDirectory())
        let zipFileUrl = tempDir.appendingPathComponent("mhb.zip")
        do {
            let fileManager = FileManager.default
            try data.write(to: zipFileUrl, options: .atomic)
            
            autoreleasepool {
                do {
                    try Zip.unzipFile(zipFileUrl, destination: tempDir, overwrite: true, password: password)
                }catch{
                    NSLog("=== openMHBFile: unable to unzipFile ===")
                }
            }
            try fileManager.removeItem(atPath: zipFileUrl.path)
            let tempFiles = try fileManager.contentsOfDirectory(atPath: tempDir.path)
            for file in tempFiles {
                if(file.hasSuffix(".json")) {
                    let targetFilePath = tempDir.appendingPathComponent(file).path
                    let theFileName = (targetFilePath as NSString).lastPathComponent
                    let targetFile: FileHandle? = FileHandle(forReadingAtPath: targetFilePath)
                    let json = targetFile?.readDataToEndOfFile()
                    targetFile?.closeFile()
                    let jsonString = NSString(data: json!, encoding: String.Encoding.utf8.rawValue)! as String
                    try fileManager.removeItem(atPath: targetFilePath)
                    callFlutterUploadMHBJson(jsonString: jsonString, theFileName: theFileName)
                }
            }
        } catch {
            NSLog("=== openMHBFileFailure ===")
            return ""
        }
        return ""
    }
    
    //handle the status code of MHB
    private func buildMHBStatusCode(code: String) -> [String: String] {
        var returnCodeMap = [String: String]()
        switch code {
        case "200":
            returnCodeMap["code"] = "200"
            returnCodeMap["message"] = "成功下載健康存摺！"
            return returnCodeMap
        case "102":
            returnCodeMap["code"] = "102"
            returnCodeMap["message"] = "Api_Key 錯誤。"
            return returnCodeMap
        case "201":
            returnCodeMap["code"] = "201"
            returnCodeMap["message"] = "儲存空間不足。"
            return returnCodeMap
            //case "202":
            //    returnCodeMap["code"] = "202"
            //    returnCodeMap["message"] = "詢問間隔須多於 60 秒。"
        //    return returnCodeMap
        case "205":
            returnCodeMap["code"] = "205"
            returnCodeMap["message"] = "取檔時 File_Ticket 不存在。"
            return returnCodeMap
        case "206":
            returnCodeMap["code"] = "206"
            returnCodeMap["message"] = "取檔時 File_Ticket 驗證失敗。"
            return returnCodeMap
        case "095":
            returnCodeMap["code"] = MHBErrorCode.dataprocessError
            returnCodeMap["message"] = "發生系統資料處理異常，請洽健保署聯絡窗口。"
            return returnCodeMap
        case "096":
            returnCodeMap["code"] = MHBErrorCode.noemulator
            returnCodeMap["message"] = "不支援模擬器開發使用。"
            return returnCodeMap
        case "097":
            returnCodeMap["code"] = MHBErrorCode.unexpectedError
            returnCodeMap["message"] = "發生不可預期之錯誤，請洽健保署服務裝窗口。"
            return returnCodeMap
        case "098":
            returnCodeMap["code"] = MHBErrorCode.noNetworkError
            returnCodeMap["message"] = "無網路可使用，請確認是否開啟。"
            return returnCodeMap
        case "099":
            returnCodeMap["code"] = MHBErrorCode.systembusy
            returnCodeMap["message"] = "系統忙碌中，請稍後再試。"
            return returnCodeMap
            
            
        default:
            return returnCodeMap
        }
    }
    
    public func didStartProcFalure(error: String) {
        NSLog("=== didStartProcFalure: \(error)")
        if error != "202" {
            let flutterError =  buildMHBStatusCode(code: error)
            let alertController = UIAlertController(title: flutterError["message"], message: "" , preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(confirmAction)
            presentAlert(alertController)
        }
    }
    
    // https://www.appcoda.com.tw/uialertcontroller/
    func presentAlert(_ alertController: UIAlertController) {
        let alertWindow = UIWindow()
        alertWindow.backgroundColor = nil
        alertWindow.windowLevel = .alert
        alertWindow.rootViewController = UIViewController()
        alertWindow.isHidden = false
        alertWindow.rootViewController?.present(alertController, animated: true)
    }
    
    func callFlutterUploadMHBJson(jsonString: String, theFileName: String) -> Void {
        let channel = FlutterMethodChannel(name: ChannelName.channel,
                                           binaryMessenger: controller.binaryMessenger)
        let returnDataMap =  getReturnMessageObj(methodName: "UploadMHBJson", statusCode: "200", details: jsonString, fileName: theFileName)
        channel.invokeMethod("UploadMHBJson", arguments: returnDataMap)
    }
    
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
    
    func getMHBoperation() -> Void {
        #if arch(i386) || arch(x86_64)
        NSLog("=== MHB SDK TEST not start ===")
        #else
        do {
            NSLog("=== MHB SDK init start [openMHBScreen] ===")
            try initMHB()
            NSLog("=== MHB SDK init end [openMHBScreen] ===")
            MHB.start(self)
            NSLog("=== MHB SDK end [openMHBScreen] ===")
        } catch MHBResult.configProblem {
            NSLog("=== MHB SDK Error configure [openMHBScreen] ===")
        } catch {
            NSLog("=== MHB SDK Error [openMHBScreen] ===")
        }
        #endif
    }
    
    func checkMHBFiles(result: FlutterResult) -> Void {
        #if arch(i386) || arch(x86_64)
        #else
        do {
            NSLog("=== MHB SDK init start [checkMHBFiles] ===")
            try initMHB()
            NSLog("=== MHB SDK init end [checkMHBFiles] ===")
            let files = getMHBFileNames()
            NSLog("=== MHB SDK getMHBFileNames end [checkMHBFiles] ===")
            if(0 < files.count) {
                MHB.fetchData(self, fileTicket: files[0])
            }
        } catch MHBResult.configProblem {
            NSLog("=== MHB SDK Error configure [checkMHBFiles] ===")
        } catch {
            NSLog("=== MHB SDK Error [checkMHBFiles] ===")
        }
        
        #endif
    }
    
    func getMHBFileNames() -> [String] {
        var fileTickets = [String]()
        
        let userDefault = UserDefaults.standard
        for (key, _) in userDefault.dictionaryRepresentation() {
            if(key.hasPrefix("File_Ticket_")) {
                fileTickets.append(key)
            }
        }
        return fileTickets
    }
    
    func initMHB() throws -> Void {
        if(isMHBConfigured) {
            NSLog("=== MHB SDK already init  ===")
        } else {
            #if arch(i386) || arch(x86_64)
            NSLog("=== MHB SDK TEST not initMHB ===")
            #else
            do {
                isMHBConfigured = true
                autoreleasepool {
                    NSLog("=== MHB SDK configure   ===")
                    MHB.configure(APIKey: infoForKey("MHB_API_KEY")!)
                    NSLog("=== MHB SDK configure successfully  ===")
                }
            } catch {
                NSLog("=== MHB SDK configure Error ===")
                throw MHBResult.configProblem
            }
            #endif
        }
    }
    
}
