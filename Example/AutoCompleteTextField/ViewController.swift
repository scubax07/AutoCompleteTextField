//
//  ViewController.swift
//  AutoCompleteTextField
//
//  Created by Neil Francis Ramirez Hipona on 03/19/2016.
//  Copyright (c) 2016 Neil Francis Ramirez Hipona. All rights reserved.
//

import UIKit
import AutoCompleteTextField

class ViewController: UIViewController, AutoCompleteTextFieldDataSource, AutoCompleteTextFieldDelegate {
    
    @IBOutlet weak var txtEmail: AutoCompleteTextField!
    @IBOutlet weak var txtReEmail: AutoCompleteTextField!
    @IBOutlet weak var txtPassword: AutoCompleteTextField!
    
    let domainNames = ["gmail.com",
                       "yahoo.com",
                       "hotmail.com",
                       "aol.com",
                       "comcast.net",
                       "me.com",
                       "msn.com",
                       "live.com",
                       "sbcglobal.net",
                       "ymail.com",
                       "icloud.com"]
    
    // add weighted domain names
    var weightedDomains: [ACTFWeightedDomain] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Optional setting for delegate if not setted in IB
        // txtEmail.autoCompleteTextFieldDataSource = self
        txtReEmail.autoCompleteTextFieldDataSource = self
        
        txtEmail.setDelimiter("@")
        txtReEmail.setDelimiter("@")
        
        txtEmail.autoCompleteTextFieldDelegate = self
        txtReEmail.autoCompleteTextFieldDelegate = self
        
        // Show right side complete button
        txtEmail.showAutoCompleteButtonWithImage(UIImage(named: "checked"), viewMode: .whileEditing)
        txtReEmail.showAutoCompleteButtonWithImage(UIImage(named: "checked"), viewMode: .whileEditing)
        
        // Initializing with datasource and delegate
        /*let textFieldWithDelegateAndDataSource = AutoCompleteTextField(frame: CGRect(x: 20, y: 64, width: view.frame.width - 40, height: 40), autoCompleteTextFieldDataSource: self)
         textFieldWithDelegateAndDataSource.backgroundColor = .red
         view.addSubview(textFieldWithDelegateAndDataSource)*/
        
        let g1 = ACTFDomain(text: "gmail.com", weight: 10)
        let g2 = ACTFDomain(text: "googlemail.com", weight: 5)
        let g3 = ACTFDomain(text: "google.com", weight: 4)
        let g4 = ACTFDomain(text: "georgetown.edu", weight: 1)
        weightedDomains = [g1, g2, g3, g4]
        
        /** 
         Using a custom object that comforms to protocol `ACTFWeightedDomain`
         */
        let g5 = CustomACTFDomain(customText: "google.com.ph", customWeight: 4, customObject: self)
        weightedDomains.append(g5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - AutoCompleteTextFieldDataSource
    
    func autoCompleteTextFieldDataSource(_ autoCompleteTextField: AutoCompleteTextField) -> [ACTFWeightedDomain] {
        
        return weightedDomains // AutoCompleteTextField.domainNames // domainNames
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtEmail {
            return txtReEmail.becomeFirstResponder()
        } else if textField == txtReEmail {
            return txtPassword.becomeFirstResponder()
        } else {
            return txtPassword.resignFirstResponder()
        }
    }
    
    func textField(_ textField: UITextField, changeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print("tf: \(textField.text!) \(string)")
        
        return true
    }
    
}

/** Custom class comforming to ACTFWeightedDomain */

class CustomACTFDomain: ACTFWeightedDomain {

    let text: String
    var weight: Int

    var customObject: AnyObject!
    
    public init(customText t: String, customWeight w: Int, customObject c: AnyObject! = nil) {
        
        text = t
        weight = w
        
        customObject = c
    }
    
    func updateWeightUsage() {
        weight += 1
    }
}

