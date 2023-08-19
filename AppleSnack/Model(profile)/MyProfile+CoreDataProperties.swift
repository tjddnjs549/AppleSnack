//
//  MyProfile+CoreDataProperties.swift
//  AppleSnack
//
//  Created by Macbook on 2023/08/19.
//
//

import Foundation
import CoreData


extension MyProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyProfile> {
        return NSFetchRequest<MyProfile>(entityName: "MyProfile")
    }

    @NSManaged public var blog: String?
    @NSManaged public var github: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var email: String?

}

extension MyProfile : Identifiable {

}
