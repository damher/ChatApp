//
//  ChatViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/6/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

class ChatViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: ChatViewController?
    
    /// Models
    var chat: Chat
    var messages = [Message]()
    
    /// Web socket tasks
    private var sendMessageTask: WSTask?
    private var getMessagesTask: WSTask?
    private var readMessagesTask: WSTask?
    
    // MARK: - Initialization
    required init(view: ChatViewController, chat: Chat) {
        self.view = view
        self.chat = chat
    }
    
    // MARK: - Methods
    /// Private methods
    private func setNavigationTitle() {
        view?.title = chat.setName()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.view?.tableView?.reloadData()
            if self.messages.count > 1 {
                self.view?.tableView?.scrollToRow(at: IndexPath(row: self.messages.count - 1,
                                                                section: 0),
                                                  at: .bottom,
                                                  animated: false)
            }
        }
    }
    
    private func configureWSTasks() {
        if let id = chat.id {
            sendMessageTask = WSTaskManager.shared.get(router: .send(id: id))
            getMessagesTask = WSTaskManager.shared.get(router: .messages(id: id))
            readMessagesTask = WSTaskManager.shared.get(router: .read(id: id))
            getMessagesTask?.connect()
            readMessagesTask?.connect()
        }
    }
    
    /// Other methods
    func updateData() {
        setNavigationTitle()
        configureWSTasks()
        // Callback function for received messages
        WSTask.receivedMessage = {
            if $0.chat_id == self.chat.id {
                self.messages.append($0)
                self.reloadTableView()
                self.notifyForNewChat()
            }
        }
        // Callback function for chat messages
        WSTask.getMessages = {
            self.messages = $0
            self.reloadTableView()
        }
        // Callback function notify that received messages are read
        WSTask.readMessages = { debugPrint("read") }
    }
    
    func sendMessage(_ text: String) {
        sendMessageTask?.sendMessage(text)
    }
    
    func readMessages() {
        readMessagesTask?.connect()
        WSTask.readMessages = { debugPrint("read") }
    }
    
    func notifyForNewChat() {
        chat.members?.forEach { user in
            if let id = user.id {
                let task = WSTaskManager.shared.get(router: .notifier(id: id))
                task.connect()
            }
        }
    }
    
    func rowsCount() -> Int {
        return messages.count
    }
}
