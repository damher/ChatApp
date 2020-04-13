//
//  CreateChatViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 3/13/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class CreateChatViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: CreateChatViewController?
    
    // MARK: - Initialization
    init(view: CreateChatViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    func updateView() {
        view?.nameTextField?.text = ""
    }
    
    func createChat() {
        if let text = view?.nameTextField?.text {
            if isValidData() {
                ChatRequests.group(name: text, success: { chat in
                    self.view?.navigation(chat)
                }) { error in
                    self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
                }
            }
        }
    }
}

extension CreateChatViewPresenter: Validation {
    
    // MARK: - Validation
    func isValidData() -> Bool {
        guard let text = view?.nameTextField?.text, !text.isEmpty else {
            view?.nameTextField?.presenter?.setWarning()
            return false
        }
        return true
    }
}
