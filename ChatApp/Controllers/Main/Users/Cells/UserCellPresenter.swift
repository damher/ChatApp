//
//  UserCellPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/6/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class UserCellPresenter {
    
    // MARK: - Properties
    /// View
    weak var cell: UserCell?
    
    /// Models
    var user: User?
    
    // MARK: - Initialization
    init(_ cell: UserCell, user: User?) {
        self.cell = cell
        self.user = user
    }
    
    // MARK: - Methods
    func updateCell() {
        cell?.nameLabel?.text = user?.name
    }
}
