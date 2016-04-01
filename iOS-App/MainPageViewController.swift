//
//  MainPageViewController.swift
//  iOS-App
//
//  Created by tp on 23/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import CoreData

class MainPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    
    var loggedUser : NSManagedObject!
    var cat = ["Every Category"]
    var serv: [NSManagedObject] = []
    
    
    
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
        
        tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customcell")
        
        let requestServ = NSFetchRequest(entityName: "Service")
        
        do {
            let resultatsServ = try context.executeFetchRequest(requestServ)
            for resultServ in resultatsServ as! [NSManagedObject] {
                serv.append(resultServ)
            }
        } catch {
            print("Echec de la requête Fetch !")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serv.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath)
        let service = serv[indexPath.item]
        cell.textLabel?.text = (service.valueForKey("titre") as! String)
        cell.detailTextLabel?.text = (service.valueForKey("desc") as! String)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailsService", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailsService" {
            if let indice = tableview.indexPathForSelectedRow {
                let dvc = segue.destinationViewController as! DetailsViewController
                dvc.service = serv[indice.row]
                dvc.user = loggedUser
            }
        }
        if segue.identifier == "profileSegue" {
            let dvc = segue.destinationViewController as! ProfileViewController
            dvc.user = loggedUser
        }
        if segue.identifier == "ToMap" {
            let dvc = segue.destinationViewController as! MapViewController
            dvc.user = loggedUser
        }
        if(segue.identifier == "ToHelpCreation"){
            let dvc = segue.destinationViewController as! CreateHelpViewController
            dvc.user = loggedUser
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
        return cat[row] 
    }

}
