//
//  ActivityController.swift
//  Expl0r
//
//  Created by Linda Xia on 9/10/16.
//  Copyright © 2016 CMU. All rights reserved.
//

import UIKit



class ActivityController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{

    @IBOutlet weak var activityTextField: UITextField!
    
    @IBOutlet weak var activityDropDown: UIPickerView!
    
    var activityList = ["Fun", "Food"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data for activity drop down menu 
        self.activityDropDown.delegate = self
        self.activityDropDown.dataSource = self
        self.activityDropDown.hidden = true
        
        // For tapping outside of the activity drop down, dismiss it.
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
        
        return activityList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        self.view.endEditing(false)
        return activityList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.activityTextField.text = activityList[row]
        self.activityDropDown.hidden = true
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField == self.activityTextField {
            self.activityDropDown.hidden = false
            activityTextField.endEditing(true)
        }
    }
    
    func didTapDropDown()
    {
        self.activityDropDown.hidden = true
    }


}

