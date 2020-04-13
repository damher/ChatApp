//
//  MessageCellPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/31/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class MessageCellPresenter {

    // MARK: - Properties
    /// View
    weak var cell: MessageCell?
    
    /// Models
    var message: Message
    
    /// Other properties
    var group: Bool = false
    
    // MARK: - Initialization
    init(_ cell: MessageCell, message: Message, group: Bool) {
        self.cell = cell
        self.message = message
        self.group = group
    }
    
    // MARK: - Methods
    func updateCell() {
        if message.sender?.id == User.current?.id {
            cell?.setMessage(cell?.memberLabel, cell?.currentUserLabel)
        } else {
            cell?.setMessage(cell?.currentUserLabel, cell?.memberLabel)
        }
    }
}
