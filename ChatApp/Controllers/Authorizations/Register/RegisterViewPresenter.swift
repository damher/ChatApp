//
//  RegisterViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/9/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

class RegisterViewPresenter: AuthorizationViewProtocol {
    
    // MARK: - Properties
    /// View
    weak var view: RegisterViewController?
    
    // MARK: - Initialization
    required init(view: RegisterViewController) {
        self.view = view
    }
    
    // MARK: - Methods
    func endEditing() {
        view?.view.endEditing(true)
    }
    
    func clearTextFields() {
        view?.nameTextField?.text = ""
        view?.emailTextField?.text = ""
        view?.passwordTextField?.text = ""
        view?.confirmPasswordTextField?.text = ""
    }
    
    // MARK: - Validation
    func isValidData() -> Bool {
        
        guard let nameText = view?.nameTextField?.text,
            let emailText = view?.emailTextField?.text,
            let passwordText = view?.passwordTextField?.text,
            let confirmText = view?.confirmPasswordTextField?.text else { return false }
        
        var validFieldsCount = 4
        
        if !ValidationManager.shared.isSufficientChars(nameText) {
            view?.nameTextField?.presenter?.setWarning()
            validFieldsCount -= 1
        }
        
        if !ValidationManager.shared.isValidEmail(emailText) {
            view?.emailTextField?.presenter?.setWarning()
            validFieldsCount -= 1
        }
        
        if !ValidationManager.shared.isValidPassword(passwordText) {
            view?.passwordTextField?.presenter?.setWarning()
            validFieldsCount -= 1
        }
        
        if passwordText != confirmText {
            view?.confirmPasswordTextField?.presenter?.setWarning()
            validFieldsCount -= 1
        }
        
        if validFieldsCount != 4 {
            return false
        }
        
        return true
    }
    
    // MARK: - Request
    func registerRequest() {
        guard let nameText = view?.nameTextField?.text,
        let emailText = view?.emailTextField?.text,
        let passwordText = view?.passwordTextField?.text else { return }
        
        let data = RegisterData(name: nameText, email: emailText, password: passwordText)
        UserRequests.register(data, success: { response in
            self.view?.showAlertWith(title: Constant.Alert.verificationTitle,
                                             message: Constant.Alert.verificationMessage,
                                             actions: [],
                                             handler: { [weak self] ok in
                self?.view?.dismiss(animated: true)
            })
        }) { error in
            self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
        }
    }
}
