//
//  Categorie+CoreDataProperties.swift
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

extension Categorie {

    @NSManaged var title: String?
    @NSManaged var services: Service?

}
