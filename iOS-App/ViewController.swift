//
//  ViewController.swift
//  iOS-App
//
//  Created by tp on 14/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loginField.delegate = self;
        self.passwordField.delegate = self;
        
        /*var user = NSEntityDescription.insertNewObjectForEntityForName("User",
            inManagedObjectContext: self.managedObjectContext!) as NSManagedObject
        user.name = "Mary"
        user.mail = Float(arc4random() % 100)  */
    }
    
    @IBAction func onLoginClick(sender: AnyObject) {
        
    }
    @IBAction func onSignUpClick(sender: AnyObject) {
        	
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

