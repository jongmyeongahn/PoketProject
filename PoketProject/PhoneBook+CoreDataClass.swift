//
//  PhoneBook+CoreDataClass.swift
//  PoketProject
//
//  Created by arthur on 7/19/24.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let calssName = "PhoneBook"
    public enum Key {
        static let imageUrl = "imageUrl"
        static let name = "name"
        static let phoneNumber = "phoneNumber"
    }

}
