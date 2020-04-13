//
//  User+CoreDataClass.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/31/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case token
        case logged
        case is_current
        case image
        case chat_set
        case messages
    }

    @NSManaged public var created: Date?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var logged: Bool
    @NSManaged public var name: String?
    @NSManaged public var token: String?
    @NSManaged public var is_current: Bool
    @NSManaged public var chat_set: Set<Chat>?
    @NSManaged public var messages: Set<Message>?
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
                else {
            fatalError("Failed to decode User")
        }
            
        self.init(entity: entity, insertInto: nil)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        logged = try container.decodeIfPresent(Bool.self, forKey: .logged) ?? false
        is_current = try container.decodeIfPresent(Bool.self, forKey: .is_current) ?? false
        image = try container.decodeIfPresent(Data.self, forKey: .image)
        chat_set = try container.decodeIfPresent(Set<Chat>.self, forKey: .chat_set)
        messages = try container.decodeIfPresent(Set<Message>.self, forKey: .messages)
    }
}

// MARK: - Encodable
extension User {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(token, forKey: .token)
        try container.encodeIfPresent(logged, forKey: .logged)
        try container.encodeIfPresent(is_current, forKey: .is_current)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encodeIfPresent(chat_set, forKey: .chat_set)
        try container.encodeIfPresent(messages, forKey: .messages)
    }
}
