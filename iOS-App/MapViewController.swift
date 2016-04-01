//
//  MapViewController.swift
//  iOS-App
//
//  Created by tp24 on 25/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var user : NSManagedObject!
    
    var manager:CLLocationManager!
    var addresses = [""]
    var titles = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Service")
        do {
            let resultats = try context.executeFetchRequest(request)
            for result in resultats as! [NSManagedObject] {
                let address = result.valueForKey("adresse") as! String
                let title = result.valueForKey("titre") as! String
                addresses.append(address)
                titles.append(title)
            }
        } catch {
            print("Echec de la requête Fetch !")
        }
        
        var region: MKCoordinateRegion = self.map.region
        
        for add in addresses {
        let location: String = add
            var geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (placemarks?.count > 0) {
            var topResult: CLPlacemark = (placemarks?[0])!
            var placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                                
            region.span.longitudeDelta /= 8.0
            region.span.latitudeDelta /= 8.0
            self.map.setRegion(region, animated: true)
            
            self.map.addAnnotation(placemark)
            // Dessiner la region sur l'Outlet carte
            self.map.setRegion(region, animated: false)
            
            let lonDelta:CLLocationDegrees = 0.05
            let latDelta:CLLocationDegrees = 0.05
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            // Créer le gestionnaire de position
            self.manager = CLLocationManager()
            // La faire gérer par le contrôleur courant
            self.manager.delegate = self
            // Définir la précision
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            // Demander l'autorisation de géolocaliser
            self.manager.requestWhenInUseAuthorization()
            // Débuter la mise à jour de la position (au cas où on bouge)
            self.manager.startUpdatingLocation()
            }
            })
    }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Afficher les positions sur la console (lat, long et d'autres infos comme la vitesse de déplacement, l'altitude, etc)
        print(locations)
        
        // Prendre la position en tête du tableau (la dernière)
        let userLocation:CLLocation = locations[0]
        
        // Extraire lat, long et faire comme plus haut pour se positionner dessus sur la carte...
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: false)
        
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
