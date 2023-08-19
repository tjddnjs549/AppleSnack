//
//  Categorie+CoreDataProperties.swift
//  AppleSnack
//
//  Created by Macbook on 2023/08/19.
//
//

import Foundation
import CoreData


extension Categorie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categorie> {
        return NSFetchRequest<Categorie>(entityName: "Categorie")
    }

    @NSManaged public var date: Date?
    @NSManaged public var categorie: String?

}

extension Categorie : Identifiable {

}
