//
//  MessageFieldPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/6/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

class MessageFieldPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: MessageField?
    
    /// Other properties
    let placeholder = "Message"
    var placeholderIsWritten = false
    
    // MARK: - Initialization
    init(view: MessageField) { self.view = view }
    
    // MARK: - Methods
    func validateText() -> String? {
        if let text = view?.text {
            let t = text.trimmingCharacters(in: .whitespaces)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            
            if t == "Message" && !placeholderIsWritten {
                return nil
            }
            else if t.isEmpty {
                return nil
            }
            else {
                return t
            }
        }
        return nil
    }
    
    func didBeginEditing() {
        if placeholderIsWritten {
            placeholderIsWritten = false
        } else {
            if view?.text == placeholder {
                view?.text = ""
            }
        }
    }
    
    func didEndEditing() {
        if view?.text.count == 0 {
            view?.text = placeholder
        }
        else if view?.text == placeholder {
            placeholderIsWritten = true
        }
    }
    
    func messageIsSent() {
        placeholderIsWritten = false
        view?.text = placeholder
    }
}
