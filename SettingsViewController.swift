//
//  SettingsViewController.swift
//  MemShape
//
//  Created by David Liu on 2/3/18.
//  Copyright © 2018 Davidapps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        nameTextField.text = defaults.string(forKey: "name") ?? ""
        emailTextField.text = defaults.string(forKey: "email") ?? ""

        nameTextField.delegate = self
        emailTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(nameTextField.text, forKey: "name")
        defaults.set(emailTextField.text, forKey: "email")
    }

}
