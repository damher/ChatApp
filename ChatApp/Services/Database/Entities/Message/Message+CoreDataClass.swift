//
//  Message+CoreDataClass.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/31/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject, Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case chat_id = "chatID"
        case text
        case chat
        case sender
    }
    
    @NSManaged public var chat_id: String?
    @NSManaged public var id: String?
    @NSManaged public var text: String?
    @NSManaged public var chat: Chat?
    @NSManaged public var sender: User?
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedObjectContext)
                else {
            fatalError("Failed to decode Message")
        }
            
        self.init(entity: entity, insertInto: nil)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        chat = try container.decodeIfPresent(Chat.self, forKey: .chat)
        sender = try container.decodeIfPresent(User.self, forKey: .sender)
        chat_id = try container.decodeIfPresent(String.self, forKey: .chat_id)
    }
}

// MARK: - Encodable
extension Message {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(text, forKey: .text)
        try container.encodeIfPresent(chat, forKey: .chat)
        try container.encodeIfPresent(sender, forKey: .sender)
        try container.encodeIfPresent(chat_id, forKey: .chat_id)
    }
}
