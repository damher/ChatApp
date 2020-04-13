//
//  MessageData.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/4/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

struct MessageData: Codable {
    
    enum CodingKeys: CodingKey {
        case text
        case senderID
        case chatID
    }
    
    var text: String
    var senderID: String
    var chatID: String
    
    init(text: String, senderId: String, chatId: String) {
        self.text = text
        self.senderID = senderId
        self.chatID = chatId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        senderID = try container.decode(String.self, forKey: .senderID)
        chatID = try container.decode(String.self, forKey: .chatID)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(senderID, forKey: .senderID)
        try container.encode(chatID, forKey: .chatID)
    }
}
