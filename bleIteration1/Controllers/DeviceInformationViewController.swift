//
//  DeviceInformationViewController.swift
//  bleIteration1
//
//  Created by Suebtrakul Kongruangkit on 9/6/20.
//  Copyright © 2020 Suebtrakul Kongruangkit. All rights reserved.
//

import UIKit

class DeviceInformationViewController: UIViewController {

    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var connectionStateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (BleObject.instance.pairingStatus()) {
            deviceNameLabel.text = BleObject.instance.devicePeripheral.name
            identifierLabel.text = BleObject.instance.devicePeripheral.identifier.uuidString
            connectionStateLabel.text = "Connected"
        } else {
            deviceNameLabel.text = "Not connected"
            identifierLabel.text = "Not connected"
            connectionStateLabel.text = "Not connected"
        }
        
        BleObject.instance.motorTestCommand()
    }


}
