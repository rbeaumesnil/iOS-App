//
//  SignUpViewController.swift
//  iOS-App
//
//  Created by tp on 14/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import CoreData

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
        self.mailField.keyboardType = UIKeyboardType.EmailAddress
        self.passwordField.delegate = self;
        self.lastnameField.delegate = self;
        self.firstnameField.delegate = self;
        self.phoneField.delegate = self;
        self.phoneField.keyboardType = UIKeyboardType.NumberPad
        self.addressField.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func SignUpClick(sender: AnyObject) {
   
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
     let managedContext: NSManagedObjectContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        
        let user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        user.setValue(mailField.text, forKey:"mail")
        user.setValue(passwordField.text, forKey:"password")
        user.setValue(lastnameField.text, forKey:"nom")
        user.setValue(firstnameField.text, forKey:"prenom")
        user.setValue(phoneField.text, forKey:"telephone")
        user.setValue(addressField.text, forKey:"adresse")
 
        
        do {
            try managedContext.save() // 5
        } catch {
            print("Problème lors de la sauvegarde !")
        }
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Detail" {
            //            if let indexpath = table.indexPathForSelectedRow {
            let dvc = segue.destinationViewController as! detailViewController
            dvc.detail = data[sender as! Int]
            //           }
        }
    }*/
}
