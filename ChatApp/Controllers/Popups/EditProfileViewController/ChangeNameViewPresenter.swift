//
//  ChangeNameViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 3/13/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class ChangeNameViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: ChangeNameViewController?
    
    /// Other properties
    var name: String? = User.current?.name
    
    // MARK: - Initialization
    init(view: ChangeNameViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    func updateView() {
        view?.nameTextField?.text = User.current?.name
    }
    
    func changeName() {
        if let name_ = name {
            if isValidData() {
                UserRequests.changeName(name_, success: { user in
                    self.view?.dismiss(animated: true)
                }) { error in
                    self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
                }
            }
        }
    }
}

extension ChangeNameViewPresenter: Validation {
    
    // MARK: - Validation
    func isValidData() -> Bool {
        guard let text = view?.nameTextField?.text, !text.isEmpty, text != name else {
            view?.nameTextField?.presenter?.setWarning()
            return false
        }
        name = text
        return true
    }
}
