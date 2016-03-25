//
//  Service+CoreDataProperties.swift
//  iOS-App
//
//  Created by tp24 on 25/03/2016.
//  Copyright © 2016 tp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Service {

    @NSManaged var adresse: String?
    @NSManaged var datedebut: NSDate?
    @NSManaged var datefin: NSDate?
    @NSManaged var desc: String?
    @NSManaged var dureequotidienne: NSNumber?
    @NSManaged var note: NSNumber?
    @NSManaged var titre: String?
    @NSManaged var categorie: Categorie?
    @NSManaged var commentaire: Commentaire?
    @NSManaged var demandeur: User?
    @NSManaged var offreur: User?

}
