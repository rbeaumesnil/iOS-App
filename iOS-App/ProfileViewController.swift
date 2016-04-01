//
//  ProfileViewController.swift
//  iOS-App
//
//  Created by tp24 on 25/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    var user : NSManagedObject!

    @IBOutlet weak var nomField: UILabel!
    @IBOutlet weak var prenomField: UILabel!
    @IBOutlet weak var adresseField: UILabel!
    @IBOutlet weak var telField: UILabel!
    @IBOutlet weak var mailField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nomField.text = user.valueForKey("nom") as! String
        prenomField.text = user.valueForKey("prenom") as! String
        adresseField.text = user.valueForKey("adresse") as! String
        telField.text = user.valueForKey("telephone") as! String
        mailField.text = user.valueForKey("mail") as! String
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "BackToMain"){
            let dvc = segue.destinationViewController as! MainPageViewController
            dvc.loggedUser = user
        }
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
