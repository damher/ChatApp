//
//  ChangePasswordViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 3/13/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class ChangePasswordViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: ChangePasswordViewController?
    
    // MARK: - Initialization
    init(view: ChangePasswordViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    func updateView() {
        view?.oldPasswordTextField?.text = ""
        view?.newPasswordTextField?.text = ""
        view?.confirmPasswordTextField?.text = ""
    }
    
    func changePassword() {
        if isValidData() {
            if let pwd = view?.newPasswordTextField?.text {
                UserRequests.changePassword(pwd, success: { user in
                    self.view?.dismiss(animated: true)
                }) { error in
                    self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
                }
            }
        }
    }
}

extension ChangePasswordViewPresenter: Validation {
    
    // MARK: - Validation
    func isValidData() -> Bool {
        guard let old = view?.oldPasswordTextField?.text,
            let new = view?.newPasswordTextField?.text,
            let confirm = view?.confirmPasswordTextField?.text else { return false }
        
        if old != UserDefaultsManager.password {
            view?.oldPasswordTextField?.presenter?.setWarning()
            return false
        }
        
        if !ValidationManager.shared.isValidPassword(new) {
            view?.newPasswordTextField?.presenter?.setWarning()
            return false
        }
        
        if confirm != new {
            view?.confirmPasswordTextField?.presenter?.setWarning()
            return false
        }
        
        return true
    }
}
