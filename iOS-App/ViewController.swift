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
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Categorie")
        request.returnsObjectsAsFaults = false
        do {
            let resultats = try context.executeFetchRequest(request)
            if resultats.count == 0 {
                
                let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
                
                let entity = NSEntityDescription.entityForName("Categorie", inManagedObjectContext: managedContext)
                
                let cat1 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                let cat2 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                let cat3 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                let cat4 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                cat1.setValue("Do It Yourself", forKey:"title")
                cat2.setValue("Language", forKey:"title")
                cat3.setValue("Coaching", forKey:"title")
                cat4.setValue("Others", forKey:"title")
                
                
                do {
                    try managedContext.save()
                } catch {
                    print("Problème lors de la sauvegarde !")
                }
            }
        } catch {
            print("Echec de la requête Fetch !")
        }
                
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SignIn" {
            let mainPage = segue.destinationViewController as! MainPageViewController
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext
            let request = NSFetchRequest(entityName: "User")
            request.predicate = NSPredicate(format: "mail = %@", loginField.text!)
            request.returnsObjectsAsFaults = false
            do {
                let resultats = try context.executeFetchRequest(request)
                mainPage.loggedUser = resultats[0] as! NSManagedObject
            } catch {
                print("Echec de la requête Fetch !")
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        var segueShouldOccur : Int = 4 //variable pour le code d'erreur // 3 erreur inconnue
        if identifier == "SignIn" {
            //teste si les champs ont été remplis
            if(loginField.text == "" || passwordField.text == ""){
                //// code erreur 1 champs incomplets 
                segueShouldOccur = 1
            }
            else {
                //requete avec l'adresse mail donnée
                let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context: NSManagedObjectContext = appDel.managedObjectContext
                let request = NSFetchRequest(entityName: "User")
                request.predicate = NSPredicate(format: "mail = %@", loginField.text!)
                request.returnsObjectsAsFaults = false
                do {
                    let resultats = try context.executeFetchRequest(request)
                    //teste si le user existe
                    if resultats.count == 1 {
                        for result in resultats as! [NSManagedObject] {
                            let attendedPassword = result.valueForKey("password") as! String
                            //teste si le password est bon
                            if passwordField.text == attendedPassword  {
                                ////code erreur 0 code bon
                                segueShouldOccur = 0
                            }
                            else {
                                ////code erreur 3 code invalide
                                segueShouldOccur = 3
                            }
                        }
                    } else {
                        ////code erreur 2 le user n'existe pas
                        segueShouldOccur = 2
                    }
                } catch {
                    print("Echec de la requête Fetch !")
                }
                
            }
            if (!(segueShouldOccur == 0)) {
                //teste les codes d'erreur
                var error : String = "";
                if segueShouldOccur == 1 {
                    error = "Please complete fields"
                }
                else if  segueShouldOccur == 2 {
                    error = "User does not exist"
                }
                else if segueShouldOccur == 3 {
                    error = "Wrong password"
                }
                else if segueShouldOccur == 4 {
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

}

