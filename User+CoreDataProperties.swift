//
//  User+CoreDataProperties.swift
//  iOS-App
//
//  Created by tp on 29/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var adresse: String?
    @NSManaged var mail: String?
    @NSManaged var nom: String?
    @NSManaged var scoreTotal: NSNumber?
    @NSManaged var password: String?
    @NSManaged var prenom: String?
    @NSManaged var telephone: String?
    @NSManaged var nbNote: NSNumber?
    @NSManaged var comm: NSSet?
    @NSManaged var servicescree: NSSet?
    @NSManaged var servicesutil: NSSet?

}
