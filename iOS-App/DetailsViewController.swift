    //
//  DetailsViewController.swift
//  iOS-App
//
//  Created by tp24 on 25/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    var service : NSManagedObject!
    
    @IBOutlet weak var titleField: UILabel!
    @IBOutlet weak var descField: UILabel!
    @IBOutlet weak var dateDebut: UILabel!
    @IBOutlet weak var dateFin: UILabel!
    @IBOutlet weak var dayDuration: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // Do any additional setup after loading the view.
        titleField.text = service.valueForKey("titre") as! String
        descField.text = service.valueForKey("desc") as! String
        var datedeb = service.valueForKey("datedebut") as! NSDate
        dateDebut.text = dateDebut.text! + " : " + dateFormatter.stringFromDate(datedeb) as! String
        var datefin = service.valueForKey("datefin") as! NSDate
        dateFin.text = dateFin.text! + " : " + dateFormatter.stringFromDate(datefin) as! String
        var duration = service.valueForKey("dureequotidienne")
        dayDuration.text = dayDuration.text! + " : " + (duration?.stringValue)!
        
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
