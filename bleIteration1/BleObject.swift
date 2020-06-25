//
//  bleObject.swift
//  bleIteration1
//
//  Created by Suebtrakul Kongruangkit on 9/6/20.
//  Copyright © 2020 Suebtrakul Kongruangkit. All rights reserved.
//

import Foundation
import CoreBluetooth


protocol ConnectionListener: AnyObject {
    func connectionDidChange(isConnect: Bool)
}

class BleObject: NSObject {
    
    
    
    
    static let instance = BleObject()
    
    var centralManager: CBCentralManager!
    var devicePeripheral: CBPeripheral!
    var txCharacteristic: CBCharacteristic!
    var rxCharacteristic: CBCharacteristic!
//    var transferServices = TransferServices()
    
    
    
    
    
    func scanDevice() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func getCurrentDevice() {
        print(devicePeripheral ?? "No device connected")
    }
    
    func pairingStatus() -> Bool {
        return devicePeripheral?.state == CBPeripheralState.connected
    }
    
    func cleanUp() {
        // do nothing if the device is not connected
        guard let discoveredPeripheral = devicePeripheral, case .connected = discoveredPeripheral.state else { return }
        
        
        // CLEAN UP ALL NOTIFY
//        for service in (devicePeripheral.services ?? [] as [CBService]) {
//            for characteristic in (service.characteristics ?? [] as [CBCharacteristic]) {
//                if characteristic.uuid == TransferServices.
//            }
//        }
        
        centralManager.cancelPeripheralConnection(devicePeripheral)
        
    }
    
    func motorTestCommand() {
        let cmdBytes: [UInt8] = [0xAA, 0xA5, 0x04, 0x14, 0x06, 0x10, 0x02, 0x00]
        let cmd = Data(cmdBytes)
        devicePeripheral.writeValue(cmd, for: txCharacteristic, type: .withResponse)
    }
    
}

extension BleObject: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unknown:
                print("central.state is .unknown")
                return
            case .resetting:
                print("central.state is .resetting")
                return
            case .unsupported:
                print("central.state is .unsupported")
                return
            case .unauthorized:
                print("central.state is .unauthorized")
                return
            case .poweredOff:
                print("central.state is .poweredoff")
                return
            case .poweredOn:
                print("central.state is .poweredon")
                centralManager.scanForPeripherals(withServices: nil)
        }
    }
    
    // scan device and connect to it
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        if (peripheral.name == "CleanSpace-HALO") {
            devicePeripheral = peripheral
            peripheral.delegate = self
            centralManager.stopScan()
            centralManager.connect(devicePeripheral)
            print("scanning: CleanSpace-HALO found")
        }
        
//        print(peripheral)
        
    }
    
    // after device has been connected
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Device is connected!")
        
        devicePeripheral.discoverServices([TransferServices.UUID_TRANSPARENT_PRIVATE_SERVICE])
    }
    
    // fail to connect
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Fail the connection")
        cleanUp()
        print("Cleaned up peripheral")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected")
    }
    
}

extension BleObject: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            print("SERVICE: \(service)")
            peripheral.discoverCharacteristics(
                [
                    TransferServices.UUID_TRANSPARENT_TX_PRIVATE_CHAR,
                    TransferServices.UUID_TRANSPARENT_RX_PRIVATE_CHAR
                ],
                for: service
            )
            
            
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let serviceCharacteristics = service.characteristics else { return }
        for characteristic in serviceCharacteristics {
            switch characteristic.uuid {
            case TransferServices.UUID_TRANSPARENT_TX_PRIVATE_CHAR:
                txCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: txCharacteristic)
                print("TX is found and set notify")
            case TransferServices.UUID_TRANSPARENT_RX_PRIVATE_CHAR:
                rxCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: rxCharacteristic)
                print("RX is found and set notify")
            default:
                continue
            }
        }
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        switch characteristic.uuid {
//            case
//        }
//        guard let characteristicData = characteristic.value, let stringFromData = String(data: characteristicData, encoding: .utf8) else { return }
//        print(characteristic)
//        let characteristicData = characteristic.value
        guard let characteristicData = characteristic.value else { return }
        print("DATA RECEIVED: \(characteristicData)")
        
        
        let byteArray = [UInt8](characteristicData)
        print("Byte array:", printHexa(data: byteArray))
        receiveNewBytes(newBytes: byteArray)
        
        
        // checksum
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
//        if characteristic.isNotifying {
//            // Notification has started
//            print("Notification began on %@", characteristic)
//        } else {
//            // Notification has stopped, so disconnect from the peripheral
//            print("Notification stopped on %@. Disconnecting", characteristic)
////            cleanup()
//        }
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic.value)
    }
}
