import UIKit
import Flutter
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    //customize error enum
    enum SendDataError: Error{
        case CharacteristicNotFound
    }
    //GATT
    let C001_CHARACTERISTIC = "001"
    var centralManager: CBCentralManager!
    //stroe connected peripheral, this variable must be global.
    var connectPeripheral: CBPeripheral!
    //recorded all characteristic
    var charDictionary = [String: CBCharacteristic]()
    //timer
    var timer: Timer!
    var isRun: Bool!
    //flutter controller
    var controller:FlutterViewController!
    //flutter channel
    var channel:FlutterMethodChannel!
    //counter
    var counter: Int!

    //===============================================================================

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.controller = (window?.rootViewController as! FlutterViewController)
        self.channel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                            binaryMessenger: controller.binaryMessenger)

        self.channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            // Note: this method is invoked on the UI thread.
            //            guard call.method == "getBatteryLevel" else {
            //                result(FlutterMethodNotImplemented)
            //                return
            //            }
            print(self!.C001_CHARACTERISTIC)
            result("======================")
            //Do any additional setup after loading the view, typically from a nib.
            let queue = DispatchQueue.global()
            //trigger method 1.
            self!.centralManager = CBCentralManager(delegate: self, queue: queue)
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    /*
     *  method 1.
     **/
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //to determine bluetooth is open or not.
        //if it is not bluetooth 4.x, return no bluetooth also.
        guard central.state == .poweredOn else{
            //to show a pop-up window for reminding user.
            return;
        }
        self.isRun = true
        //before jump to method 2, init counter.
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
        self.counter = 0;
        //todo: test retrieve connected peripheral
//         centralManager.retrieveConnectedPeripherals()
        //jump to method 2
       centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    @objc func timerAction(){
        print("do something")
        self.isRun = false
    }

    /*
     * method 2.
     **/
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let deviceName = peripheral.name else {
            return
        }
        print("\nThe found bluetooth device's name is:\(deviceName)")
        self.channel.invokeMethod("callBack", arguments: deviceName)
        self.counter += 1;
        if self.counter != 30 {return}
        central.stopScan()

        connectPeripheral = peripheral
        connectPeripheral.delegate = self

        //this will trigger method 3
        centralManager.connect(connectPeripheral, options: nil)
    }
    /*
     * method 3.
     **/
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // clean up the characteristic in the history.
        charDictionary = [:]
        //will trigger method 4.
        peripheral.discoverServices(nil)
    }
    /*
     * method 4.
     **/
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            return
        }
        for service in peripheral.services!{
            //will trigger method 5
            connectPeripheral.discoverCharacteristics(nil, for: service)
        }
    }

    /*
     * method 5.
     **/
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            return
        }
        print(service)
        for characteristic in service.characteristics!{
            let uuidString = characteristic.uuid.uuidString
            charDictionary[uuidString] = characteristic
            print("\nFound: \(uuidString)")
            print("characteristic: \(characteristic)")
        }
    }

    func sendData(_ data: Data, uuidString: String, writeType:CBCharacteristicWriteType)throws{
        guard let characteristic = charDictionary[uuidString] else {
            throw SendDataError.CharacteristicNotFound
        }
        connectPeripheral.writeValue(
            data,for: characteristic,type: writeType
        )
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        guard error == nil else{
            return
        }
    }

}
