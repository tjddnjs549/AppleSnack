//
//  MySnack+CoreDataProperties.swift
//  AppleSnack
//
//  Created by Macbook on 2023/08/19.
//
//

import Foundation
import CoreData


extension MySnack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MySnack> {
        return NSFetchRequest<MySnack>(entityName: "MySnack")
    }

    @NSManaged public var assiURL: String?
    @NSManaged public var categorie: String?
    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    
    var dateString: String? {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "M월 dd일 EE요일"
            guard let date = self.date else { return "" }
            let savedDateString = myFormatter.string(from: date)
            return savedDateString
        }

}

extension MySnack : Identifiable {

}
