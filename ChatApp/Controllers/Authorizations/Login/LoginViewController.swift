//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: LoginViewPresenter?
    
    /// IBOutlet properties
    @IBOutlet weak var emailTextField: RoundedTextField?
    @IBOutlet weak var passwordTextField: RoundedTextField?
    
    // MARK: - Deinitialization
    deinit { debugPrint("LoginViewController Deinitialized") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginViewPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.clearTextFields()
    }
    
    // MARK: - Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter?.endEditing()
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: RoundedButton) {
        presenter?.endEditing()
        
        guard let isValid = presenter?.isValidData() else { return }
        if isValid {
            presenter?.login { [weak self] in
                let sb = UIStoryboard(name: UIStoryboard.Name.main, bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: UIStoryboard.Identity.navigation)
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
        }
    }
}
