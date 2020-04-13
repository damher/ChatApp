//
//  Chat+CoreDataClass.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/31/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Chat)
public class Chat: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case unread_count
        case last_message
        case members
        case group
        case name
    }
    
    @NSManaged public var id: String?
    @NSManaged public var unread_count: Int64
    @NSManaged public var last_message: Message?
    @NSManaged public var members: Set<User>?
    @NSManaged public var group: Bool
    @NSManaged public var name: String?
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Chat", in: managedObjectContext)
                else {
            fatalError("Failed to decode Chat")
        }
            
        self.init(entity: entity, insertInto: nil)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        unread_count = try container.decodeIfPresent(Int64.self, forKey: .unread_count) ?? 0
        last_message = try container.decodeIfPresent(Message.self, forKey: .last_message)
        members = try container.decodeIfPresent(Set<User>.self, forKey: .members)
        group = try container.decodeIfPresent(Bool.self, forKey: .group) ?? false
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}

// MARK: - Encodable
extension Chat {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(unread_count, forKey: .unread_count)
        try container.encodeIfPresent(last_message, forKey: .last_message)
        try container.encodeIfPresent(members, forKey: .members)
        try container.encodeIfPresent(group, forKey: .group)
        try container.encodeIfPresent(name, forKey: .name)
    }
}
