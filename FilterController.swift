//
//  FilterController.swift
//  Expl0r
//
//  Created by Linda Xia on 9/9/16.
//  Copyright © 2016 CMU. All rights reserved.
//

import UIKit

    public var chosenMode = ""

class FilterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var timeDropDown: UIPickerView!

    @IBOutlet weak var timeTextField: UITextField!
    
    var timeList = ["Full-day", "Half-day", "Surprise me!"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Connect data for time drop down menu
        self.timeDropDown.delegate = self
        self.timeDropDown.dataSource = self
        self.timeDropDown.hidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(FilterController.didTapDropDown))
        self.view.addGestureRecognizer(tap)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return timeList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        self.view.endEditing(false)
        return timeList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.timeTextField.text = timeList[row]
        self.timeDropDown.hidden = true
        chosenMode = self.timeTextField.text!
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField == self.timeTextField {
            self.timeDropDown.hidden = false
            timeTextField.endEditing(true)
        }
    }
    
    func didTapDropDown()
    {
//        self.timeDropDown.selectedRowInComponent(<#T##component: Int##Int#>)
//        self.view.endEditing(true)
        self.timeDropDown.hidden = true
    }





}






