//
//  MainPageViewController.swift
//  iOS-App
//
//  Created by tp on 23/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import CoreData

class MainPageViewController: UIViewController{
    
    var loggedUser : String = ""
    var cat = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Categorie")
        
        do {
            let resultats = try context.executeFetchRequest(request)
            for result in resultats as! [NSManagedObject] {
                let title = result.valueForKey("title") as! String
                cat.append(title)
            }
        } catch {
            print("Echec de la requête Fetch !")
        }
        
        
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cat.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
        {
        return cat[row] as! String
    }
}
