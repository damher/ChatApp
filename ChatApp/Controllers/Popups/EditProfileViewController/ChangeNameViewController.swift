//
//  EditProfileViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/27/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class ChangeNameViewController: PopupViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: ChangeNameViewPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ChangeNameViewPresenter(view: self)
        setTitle("CHANGE IMAGE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateView()
        setCurrentUserNeme()
    }
    
    // MARK: - Methods
    /// Other methods
    func setCurrentUserNeme() {
        nameTextField?.text = presenter?.name
    }
    
    /// Override methods
    override func okButtonIsClicked(_ sender: UIButton) {
        super.okButtonIsClicked(sender)
        presenter?.changeName()
    }
}
