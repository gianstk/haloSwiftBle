//
//  ViewController.swift
//  bleIteration1
//
//  Created by Suebtrakul Kongruangkit on 1/6/20.
//  Copyright © 2020 Suebtrakul Kongruangkit. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func pageSelectedPressed(_ sender: UIButton) {
        var buttonTitle = sender.titleLabel?.text! ?? "Invalid"
        switch buttonTitle {
            case "Bluetooth Pairing":
                self.performSegue(withIdentifier: "goToPairing", sender: self)
            case "Device Information":
                self.performSegue(withIdentifier: "goToDeviceInformation", sender: self)
            default:
                print("Invalid page")
        }
    }
    
    
    
    // prepare before loading a new page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPairing" {
            let destinationVC = segue.destination as! BluetoothPairViewController
//            destinationVC.delete(self)
        }
        else if segue.identifier == "goToDeviceInformation" {
            let destinationVC = segue.destination as! DeviceInformationViewController
        }
        
    }
    
}
