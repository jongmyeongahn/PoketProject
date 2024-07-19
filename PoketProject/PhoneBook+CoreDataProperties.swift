//
//  PhoneBook+CoreDataProperties.swift
//  PoketProject
//
//  Created by arthur on 7/19/24.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var imageUrl: Data?
    @NSManaged public var name: String?
    @NSManaged public var number: String?

}

extension PhoneBook : Identifiable {

}
