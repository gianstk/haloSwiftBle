//
//  BluetoothPairViewController.swift
//  bleIteration1
//
//  Created by Suebtrakul Kongruangkit on 2/6/20.
//  Copyright © 2020 Suebtrakul Kongruangkit. All rights reserved.
//

import UIKit
//import CoreBluetooth

class BluetoothPairViewController: UIViewController {

    // Variables
    var deviceName: String?
//    var delegate: isAbleToReceiveBle!
    
    // UIView
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var pairStatusLabel: UILabel!
    
    
    // BLE
//    var centralManager: CBCentralManager!
//    var haloPeripheral: CBPeripheral!
//    var bleObject = BleObject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairStatusLabel.text = "Scanning devices"
        BleObject.instance.scanDevice()
        
//        while (!BleObject.instance.pairingStatus()) {
//
//        }
//        pairStatusLabel.text = "Device connected"
        
    }
    
    
    
    
    @IBAction func backPressed(_ sender: UIButton) {
//        var delegate: isAbleToReceiveData
//        viewWillDisappear(delegate.pass()
//        delegate.pass(data: bleObject)
        
        self.dismiss(animated: true, completion: nil)
        print("back to dashboard")
    }
    

}

//extension BluetoothPairViewController: CBCentralManagerDelegate {
//
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch central.state {
//            case .unknown:
//              print("central.state is .unknown")
//            case .resetting:
//              print("central.state is .resetting")
//            case .unsupported:
//              print("central.state is .unsupported")
//            case .unauthorized:
//              print("central.state is .unauthorized")
//            case .poweredOff:
//              print("central.state is .poweredoff")
//            case .poweredOn:
//              print("central.state is .poweredon")
//              centralManager.scanForPeripherals(withServices: nil)
//        }
//    }
//
//    // scan device and connect to it
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
////        if (peripheral.name == "HALO-G0001022") {
////            print(peripheral)
////            haloPeripheral = peripheral
////            haloPeripheral.delegate = self
////            centralManager.stopScan()
////            centralManager.connect(haloPeripheral)
////            deviceNameLabel.text = peripheral.name
////            pairStatusLabel.text = "Connected"
////        }
//        print(peripheral);
//    }
//
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        print("Connected!")
//
//        haloPeripheral.discoverServices(nil)
//    }
//
//
//}
//
//
//extension BluetoothPairViewController: CBPeripheralDelegate {
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        guard let services = peripheral.services else { return }
//        for service in services {
//            print("SERVICE: \(service)")
//        }
//    }
//}
