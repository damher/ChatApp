//
//  User+CoreDataProperties.swift
//  iChat
//
//  Created by Mher Davtyan on 1/27/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//
//

import Foundation
import CoreData


extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
}

// MARK: Generated accessors for chat_set
extension User {

    @objc(addChat_setObject:)
    @NSManaged public func addToChat_set(_ value: Chat)

    @objc(removeChat_setObject:)
    @NSManaged public func removeFromChat_set(_ value: Chat)

    @objc(addChat_set:)
    @NSManaged public func addToChat_set(_ values: NSSet)

    @objc(removeChat_set:)
    @NSManaged public func removeFromChat_set(_ values: NSSet)

}
