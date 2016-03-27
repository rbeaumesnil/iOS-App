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
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        var segueShouldOccur : Int = 3 //variable pour le code d'erreur // 3 erreur inconnue
        if identifier == "SignUp" {
            //test si les champs sont remplis
            if(mailField.text == "" || passwordField.text == "" || lastnameField.text == "" || firstnameField.text == "" || phoneField.text == "" || addressField.text == ""){
                ////code erreur 1 champs incomplets
                segueShouldOccur = 1
            }
            //test si le user existe
            else {
                //requete
                let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context: NSManagedObjectContext = appDel.managedObjectContext
                let request = NSFetchRequest(entityName: "User")
                request.predicate = NSPredicate(format: "mail = %@", mailField.text!)
                request.returnsObjectsAsFaults = false
                do {
                    let resultats = try context.executeFetchRequest(request)
                    //compte si il y a déjà des utilisateurs existant avec ce mail
                    if resultats.count > 0 {
                        ////code erreur 2 si le mail a déjà été utilisé par un compte
                        segueShouldOccur = 2
                    } else {
                        ////code erreur 0 si le mail est valide
                        segueShouldOccur = 0
                    }
                } catch {
                    print("Echec de la requête Fetch !")
                }
            }
            if segueShouldOccur != 0{
                //test les codes d'erreur
                var error : String = "";
                if segueShouldOccur == 1 {
                    error = "Please complete fields"
                }
                else if  segueShouldOccur == 2 {
                    error = "User already exist"
                }
                else if segueShouldOccur == 3 {
                    error = "Unknown error"
                }
                //popup erreur
                let alert = UIAlertController (title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(OKAction)
                presentViewController(alert, animated: true, completion: nil)
                
                // invalide le segue
                return false
            }
        }
        
        // valide le segue
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SignUp" {
            //requete ajout user
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
                try managedContext.save()
            } catch {
                print("Problème lors de la sauvegarde !")
            }        }
    }
}
