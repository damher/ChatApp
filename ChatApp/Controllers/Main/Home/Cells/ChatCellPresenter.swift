//
//  UserCellPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/6/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

class ChatCellPresenter {

    // MARK: - Properties
    /// View
    weak var cell: ChatCell?
    
    /// Models
    var chat: Chat?
    
    // MARK: - Initialization
    init(_ cell: ChatCell, chat: Chat?) {
        self.cell = cell
        self.chat = chat
    }
    
    // MARK: - Methods
    /// Private methods
    private func configureCountLabel() {
        guard let c = chat?.unread_count else { return }
        
        setBackgroundColor(c == 0)
        cell?.imgView?.color = c == 0 ? .systemRed : .white
        cell?.countLabel?.isHidden = (c == 0)
        cell?.nameLabel?.textColor = (c == 0) ? .viewFlipside : .white
        cell?.lastMessageLabel?.textColor = (c == 0) ? .systemGray : .white
        cell?.senderLabel?.textColor = (c == 0) ? .systemRed : .white
        cell?.countLabel?.text = (c == 0) ? "" : "\(c)"
    }
    
    private func configureLastMessageLabel() {
        cell?.lastMessageLabel?.text = ""
        cell?.senderLabel?.text = ""
        
        guard let sender = chat?.last_message?.sender?.name,
            let text = chat?.last_message?.text else { return }
        
        if chat?.last_message?.sender?.id == User.current?.id {
            cell?.senderLabel?.text = "Me"
        } else {
            cell?.senderLabel?.text = "\(sender)"
        }
        
        cell?.lastMessageLabel?.text = text
    }
    
    private func setBackgroundColor(_ checkedChat: Bool) {
        if checkedChat {
            cell?.content?.firstColor = .white
            cell?.content?.secondColor = .white
            cell?.content?.thirdColor = .white
            cell?.content?.backgroundColor = .white
        } else {
            cell?.content?.firstColor = .systemRed
            cell?.content?.secondColor = .systemRed
            cell?.content?.thirdColor = .systemPink
        }
    }
    
    /// Other methods
    func updateCell() {
        cell?.nameLabel?.text = chat?.setName()
        configureCountLabel()
        configureLastMessageLabel()
    }
}
