//
//  Chat+CoreDataProperties.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/31/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//
//

import Foundation
import CoreData

extension Chat {
    
    func setName() -> String {
        if self.name != nil {
            return self.name!
        }
        
        self.members?.forEach { user in
            if user.id == User.current?.id {
                self.members?.remove(user)
            }
        }
        
        var newName = ""
        
        if let members = self.members {
            for (index, member) in members.enumerated() {
                switch index {
                case 0:
                    newName += member.name ?? ""
                default:
                    newName += ", " + (member.name ?? "")
                }
            }
        }
        
        return newName
    }
}

extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }
}

// MARK: - Generated accessors for members
extension Chat {

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: User)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: User)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: Set<User>)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: Set<User>)

}
