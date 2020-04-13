//
//  LoginViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/9/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

class LoginViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: LoginViewController?
    
    // MARK: - Initialization
    required init(view: LoginViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    func endEditing() {
        view?.view.endEditing(true)
    }
    
    func clearTextFields() {
        view?.emailTextField?.text = ""
        view?.passwordTextField?.text = ""
    }
    
    // MARK: - Validation
    func isValidData() -> Bool {
        guard let emailText = view?.emailTextField?.text,
            let passwordText = view?.passwordTextField?.text else { return false }
        
        var validFieldsCount = 2
        
        if !ValidationManager.shared.isValidEmail(emailText) {
            view?.emailTextField?.presenter?.setWarning()
            validFieldsCount -= 1
        }
        
        if !ValidationManager.shared.isValidPassword(passwordText) {
            view?.passwordTextField?.presenter?.setWarning()
            validFieldsCount -= 1
        }
        
        if validFieldsCount != 2 {
            return false
        }
        
        return true
    }
    
    // MARK: - Request
    func login(_ logged: @escaping ()->Void) {
        guard let emailText = view?.emailTextField?.text,
        let passwordText = view?.passwordTextField?.text else { return }
        
        UserRequests.login(emailText, passwordText, success: { user in
            logged()
        }) { error in
            self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
        }
    }
}
