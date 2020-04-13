//
//  MainNavigationController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/28/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    // MARK: - Properties
    /// Presenter
    var presenter: MainNavigationPresenter?
    
    /// Override properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    /// Menu
    lazy private var menu: MenuViewController? = {
        MenuViewController.instance(items: presenter?.menuItems ?? [])
    }()
    
    // MARK: - Deinitialization
    deinit { debugPrint("MainNavigationController Deinitialized") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainNavigationPresenter(view: self)
        navigationBar.shadowImage = UIImage.create(CGSize(width: view.frame.width, height: 0))
        menu?.config(self)
    }
    
    func openMenu() {
        menu?.showMenu()
    }
}
