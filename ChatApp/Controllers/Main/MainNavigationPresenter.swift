//
//  MainNavigationPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 3/3/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class MainNavigationPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: MainNavigationController?
    
    /// Menu items
    var menuItems: [MenuItem] = [
        MenuItem(title: "Home", controller: nil),
        MenuItem(title: "Create chat",
                 controller: CreateChatViewController(nibName: "\(CreateChatViewController.self)", bundle: nil)),
        MenuItem(title: "Change name",
                 controller: ChangeNameViewController(nibName: "\(ChangeNameViewController.self)", bundle: nil)),
        MenuItem(title: "Change password",
                 controller: ChangePasswordViewController(nibName: "\(ChangePasswordViewController.self)", bundle: nil))]
    
    // MARK: - Initialization
    required init(view: MainNavigationController) {
        self.view = view
    }
}
