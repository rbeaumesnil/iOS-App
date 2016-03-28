//
//  MapViewController.swift
//  iOS-App
//
//  Created by tp24 on 25/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let latitude:CLLocationDegrees = 47.845512
        let longitude:CLLocationDegrees = 1.939834
        
        let lonDelta:CLLocationDegrees = 0.05
        let latDelta:CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        
        //Définir un point dans la carte
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        // Décider de la région à afficher (centrée sur le point défini)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        // Dessiner la region sur l'Outlet carte
        map.setRegion(region, animated: false)
        
        // Créer l'objet annotaion
        var annotation = MKPointAnnotation()
        
        // Lui donner les coordonnées définis plus haut
        annotation.coordinate = location
        
        // Décorer l'annotation avec un titre et un sous-titre
        annotation.title = "Un titre du coin"
        
        //annotation.subtitle = "Un petit texte qui le détaille..."
        
        // Ajouter l'annotation à la carte : Pin cliquable avec apparition du texte
        map.addAnnotation(annotation)
         
        // Créer le gestionnaire de position
        manager = CLLocationManager()
        // La faire gérer par le contrôleur courant
        manager.delegate = self
        // Définir la précision
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // Demander l'autorisation de géolocaliser
        manager.requestWhenInUseAuthorization()
        // Débuter la mise à jour de la position (au cas où on bouge)
        manager.startUpdatingLocation()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
