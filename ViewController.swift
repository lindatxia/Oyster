//
//  ViewController.swift
//  Expl0r
//
//  Created by Raunak Gupta on 9/9/16.
//  Copyright © 2016 CMU. All rights reserved.
//

import UIKit
import MapKit

public var inputtedAddress = ""

class ViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        textField.textColor = textColor
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var textField: UITextField!

    
    @IBAction func AddButton(sender: UIButton) {
        
        inputtedAddress = textField.text!
        textField.keyboardType = UIKeyboardType.Default
        textField.resignFirstResponder()
    
    }

    

    

}
