//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

struct CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    //MARK: - Profile
    // current user
    var currentUser: User? {
        return User.current
    }
    
    func saveUser(_ u: User) {
        if let chats = u.chat_set { insertChats(chats) }
        CoreDataWrapper.shared.insertObject(u)
        CoreDataWrapper.shared.saveContext()
    }
    
    func updateCurrentUserName(_ user: User?) {
        User.current?.name = user?.name
        CoreDataWrapper.shared.saveContext()
    }
    
    func saveChats(_ chats: [Chat]) {
        insertChats(Set<Chat>(chats))
        
        CoreDataWrapper.shared.deleteData(entity: Chat.self) { completed in
            if completed {
                CoreDataWrapper.shared.insertObjects(chats)
                CoreDataWrapper.shared.saveContext()
            }
        }
    }
    
    func insertChats(_ chats: Set<Chat>) {
        chats.forEach { chat in
            if let members = chat.members {
                CoreDataWrapper.shared.insertObjects(Array(members))
            }
            if let msg = chat.last_message {
                insertMessage(msg)
            }
        }
        CoreDataWrapper.shared.insertObjects(Array(chats))
    }
    
    func insertMessage(_ message: Message) {
        if let sender = message.sender {
            CoreDataWrapper.shared.insertObject(sender)
        }
        CoreDataWrapper.shared.insertObject(message)
    }
}
