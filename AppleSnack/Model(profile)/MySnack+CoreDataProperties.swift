//
//  MySnack+CoreDataProperties.swift
//  AppleSnack
//
//  Created by Macbook on 2023/08/14.
//
//

import Foundation
import CoreData


extension MySnack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MySnack> {
        return NSFetchRequest<MySnack>(entityName: "MySnack")
    }

    @NSManaged public var textPhoto: Data?
    @NSManaged public var categorie: String?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var assiURL: String?

}

extension MySnack : Identifiable {

}
