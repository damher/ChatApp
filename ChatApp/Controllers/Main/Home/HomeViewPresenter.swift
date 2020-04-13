//
//  HomeViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/6/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

class HomeViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: HomeViewController?
    
    /// Models
    var chats = [Chat]()
    
    // MARK: - Initialization
    required init(view: HomeViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    /// Private methods
    private func updateChats() {
        let tasks = WSTaskManager.shared.getAll(by: .chats)
        tasks.forEach { task in
            task.connect()
            WSTask.getChats = { chats in
                chats.forEach { chat in
                    if let id = chat.id {
                        self.addMessageTasks(id: id)
                    }
                }
                
                self.chats = chats
                DispatchQueue.main.async {
                    self.view?.tableView?.reloadData()
                }
            }
        }
    }
    
    private func addMessageTasks(id: String) {
        WSTaskManager.shared.addWS(router: .send(id: id))
        WSTaskManager.shared.addWS(router: .messages(id: id))
        WSTaskManager.shared.addWS(router: .read(id: id))
    }
    
    /// Other methods
    func updateData() {
        updateChats()
        
        WSTask.receivedMessage = { _ in
            self.updateChats()
        }
        
        WSTask.readMessages = {
            self.updateChats()
        }
        
        WSTask.notifier = {
            self.updateChats()
        }
    }
    
    func rowsCount() -> Int {
        return chats.count
    }
}
