//
//  UsersViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/6/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class UsersViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: UsersViewController?
    
    /// Models
    var users = [User]()
    
    /// Other properties
    var invitationId: String?
    
    // MARK: - Initialization
    required init(view: UsersViewController, invitationId: String? = nil) {
        self.view = view
        self.invitationId = invitationId
    }
    
    // MARK: - Methods
    func getUsers() {
        UserRequests.getUsers(success: { users_ in
            self.users = users_ ?? []
            self.view?.tableView?.reloadData()
        }) { error in
            self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
        }
    }
    
    func searchUsers(by name: String) {
        UserRequests.searchUsers(name, success: { users_ in
            self.users = users_ ?? []
            self.view?.tableView?.reloadData()
        }) { error in
            self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
        }
    }
    
    func rowsCount() -> Int {
        return users.count
    }
    
    func createChat(_ id: String, isCreated: @escaping ((Chat) -> Void)) {
        ChatRequests.create(memberId: id, success: { chat in
            if let c = chat {
                WSTaskManager.shared.addWS(router: .notifier(id: id))
                if let id_ = c.id {
                    self.addMessageTasks(id: id_)
                    isCreated(c)
                }
            }
        }) { _ in
            let tasks = WSTaskManager.shared.getAll(by: .chats)
            tasks.forEach { task in
                task.connect()
                WSTask.getChats = { chats in
                    chats.forEach { [weak self] chat in
                        if let members = chat.members, !chat.group {
                            if members.contains(where: { $0.id == id }) {
                                if let id_ = chat.id {
                                    self?.addMessageTasks(id: id_)
                                    isCreated(chat)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addMember(_ userId: String) {
        ChatRequests.invite(id: invitationId!, u_id: userId, success: { _ in
            WSTaskManager.shared.addWS(router: .notifier(id: userId))
            let task = WSTaskManager.shared.get(router: .notifier(id: userId))
            task.connect()
            self.view?.showAlertWith(title: "",
                                      message: "Succesfully added",
                                      actions: ["OK"],
                                      handler: { [weak self] _ in
                self?.view?.navigationController?.popViewController(animated: true)
            })
        }) { error in
            self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
        }
    }
    
    private func addMessageTasks(id: String) {
        WSTaskManager.shared.addWS(router: .send(id: id))
        WSTaskManager.shared.addWS(router: .messages(id: id))
        WSTaskManager.shared.addWS(router: .read(id: id))
    }
}
