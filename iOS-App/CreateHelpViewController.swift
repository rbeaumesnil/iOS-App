//
//  CreateHelpViewController.swift
//  iOS-App
//
//  Created by tp24 on 25/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import CoreData

class CreateHelpViewController: UIViewController, UITextFieldDelegate {
    var user : NSManagedObject!

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var beginDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var durationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleField.delegate = self
        self.descField.delegate = self
        self.addressField.delegate = self
        self.durationField.delegate = self
        // Do any additional setup after loading the view.
        let currentDate = NSDate()
        beginDate.minimumDate = currentDate
        endDate.minimumDate = currentDate
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        var segueShouldOccur : Int = 3 //variable pour le code d'erreur // 3 erreur inconnue
        if identifier == "MainSegue" {
            //test si les champs sont remplis
            if(titleField.text == "" || descField.text == "" || addressField.text == "" || durationField.text == ""){
                ////code erreur 1 champs incomplets
                segueShouldOccur = 1
            }
                //test si le user existe
            else {
                segueShouldOccur = 0
            }
            if segueShouldOccur != 0{
                //test les codes d'erreur
                var error : String = "";
                if segueShouldOccur == 1 {
                    error = "Please complete fields"
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
        if segue.identifier == "MainSegue" {
            //requete ajout user
            let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
            
            let managedContext: NSManagedObjectContext = appDelegate!.managedObjectContext
            
            let entity = NSEntityDescription.entityForName("Service", inManagedObjectContext: managedContext)
            
            let service = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            service.setValue(titleField.text, forKey:"titre")
            service.setValue(descField.text, forKey:"desc")
            service.setValue(addressField.text, forKey:"adresse")
            service.setValue(Int(durationField.text!), forKey:"dureequotidienne")
            service.setValue(beginDate.date, forKey:"datedebut")
            service.setValue(endDate.date, forKey: "datefin")
            
            
            //let mainPage = segue.destinationViewController as! MainPageViewController
            //mainPage.loggedUser = mailField.text!
            
            let dvc = segue.destinationViewController as! MainPageViewController
            dvc.loggedUser = user
            
            do {
                try managedContext.save()
            } catch {
                print("Problème lors de la sauvegarde !")
            }
        }
        if(segue.identifier == "BackToMain"){
            let dvc = segue.destinationViewController as! MainPageViewController
            dvc.loggedUser = user
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
