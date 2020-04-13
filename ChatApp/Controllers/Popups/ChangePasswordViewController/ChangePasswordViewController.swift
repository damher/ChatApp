//
//  ChangePasswordViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/27/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class ChangePasswordViewController: PopupViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: ChangePasswordViewPresenter?
    
    // MARK: - Lifecycle
    @IBOutlet weak var oldPasswordTextField: RoundedTextField?
    @IBOutlet weak var newPasswordTextField: RoundedTextField?
    @IBOutlet weak var confirmPasswordTextField: RoundedTextField?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ChangePasswordViewPresenter(view: self)
        setTitle("CHANGE PASSWORD")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateView()
    }
    
    // MARK: - Methods
    override func okButtonIsClicked(_ sender: UIButton) {
        presenter?.changePassword()
    }
}
