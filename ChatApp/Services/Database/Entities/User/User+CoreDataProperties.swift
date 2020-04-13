//
//  User+CoreDataProperties.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/31/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//
//

import Foundation
import CoreData


extension User {
    
    class var current: User? {
        let predicate = NSPredicate(format: "is_current ==\(true)")
        let users = CoreDataWrapper.shared.fetchEntityData(entity: User.self, predicate: predicate)
        
        if users.isEmpty {
            return nil
        }
        return users.first
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
}

// MARK: - Generated accessors for chat_set
extension User {

    @objc(addChat_setObject:)
    @NSManaged public func addToChat_set(_ value: Chat)

    @objc(removeChat_setObject:)
    @NSManaged public func removeFromChat_set(_ value: Chat)

    @objc(addChat_set:)
    @NSManaged public func addToChat_set(_ values: Set<Chat>)

    @objc(removeChat_set:)
    @NSManaged public func removeFromChat_set(_ values: Set<Chat>)
}

// MARK: - Generated accessors for messages
extension User {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: Message)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: Message)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: Set<Message>)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: Set<Message>)
}
