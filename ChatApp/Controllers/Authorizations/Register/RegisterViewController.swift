//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: RegisterViewPresenter?
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var nameTextField: RoundedTextField?
    @IBOutlet weak var emailTextField: RoundedTextField?
    @IBOutlet weak var passwordTextField: RoundedTextField?
    @IBOutlet weak var confirmPasswordTextField: RoundedTextField?
    
    // MARK: - Deinitialization
    deinit { debugPrint("RegisterViewController Deinitialized") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegisterViewPresenter(view: self)
        addTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeybordNotification()
        presenter?.clearTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeybordNotification()
    }
    
    // MARK: - Keybord notifications
    override func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView?.contentInset.bottom = keyboardSize.height
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        scrollView?.contentInset.bottom = 0
    }
    
    // MARK: - Methods
    private func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(scrollTapAction))
        scrollView?.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    @IBAction func singnUpButtonTapped(_ sender: RoundedButton) {
        presenter?.endEditing()
        
        guard let isValid = presenter?.isValidData() else { return }
        if isValid {
            presenter?.registerRequest()
        }
    }
    
    @objc private func scrollTapAction() {
        presenter?.endEditing()
    }
}
