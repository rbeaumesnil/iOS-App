//
//  SignUpViewController.swift
//  iOS-App
//
//  Created by tp on 14/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!

    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mailField.delegate = self;
        self.passwordField.delegate = self;
        self.lastnameField.delegate = self;
        self.firstnameField.delegate = self;
        self.phoneField.delegate = self;
        self.addressField.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
