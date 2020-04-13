//
//  WSTaskRouter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/11/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

extension WSTask {
    
    // MARK: - Callback properties
    static var getMessages: (([Message]) -> Void)?
    static var receivedMessage: ((Message) -> Void)?
    static var readMessages: (() -> Void)?
    static var notifier: (() -> Void)?
    static var getChats: (([Chat]) -> Void)?
    
    // MARK: - Router
    enum Router {
        case messages(id: String)
        case send(id: String)
        case read(id: String)
        case notifier(id: String)
        case chats
        
        var path: String {
            switch self {
            case .messages:
                return "messages"
            case .send:
                return "send"
            case .read:
                return "read"
            case .notifier:
                return "notifier"
            case .chats:
                return "chats"
            }
        }
        
        var id: String {
            switch self {
            case .messages(let id), .send(let id), .read(let id), .notifier(let id):
                return id
            default:
                return ""
            }
        }
        
        func dataHandler(data: Data) {
            let decoder = CoreDataWrapper.shared.jsonDecoder
            
            switch self {
            case .messages:
                if let messages = try? decoder.decode([Message].self, from: data) {
                    WSTask.getMessages?(messages)
                }
            case .send:
                if let message = try? decoder.decode(Message.self, from: data) {
                    WSTask.receivedMessage?(message)
                }
            case .read:
                WSTask.readMessages?()
            case .notifier:
                WSTask.notifier?()
            case .chats:
                if let chats = try? decoder.decode([Chat].self, from: data) {
                    WSTask.getChats?(chats)
                }
            }
        }
    }
}
