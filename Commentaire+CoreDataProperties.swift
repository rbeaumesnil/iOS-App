//
//  Commentaire+CoreDataProperties.swift
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

extension Commentaire {

    @NSManaged var note: NSNumber?
    @NSManaged var text: String?
    @NSManaged var titre: String?
    @NSManaged var auteur: User?
    @NSManaged var service: Service?

}
