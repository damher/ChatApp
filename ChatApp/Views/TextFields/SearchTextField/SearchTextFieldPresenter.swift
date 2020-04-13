//
//  SearchTextFieldPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/12/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class SearchTextFieldPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: SearchTextField?
    
    // MARK: - Initialization
    required init(view: SearchTextField) {
        self.view = view
    }
    
    // MARK: - Methods
    /// Private methods
    private func validateText() -> String? {
        if view?.text?.trimmingCharacters(in: .whitespaces) == "" {
            return nil
        }
        return view?.text?.trimmingCharacters(in: .whitespaces)
    }
    
    /// Other methods
    func shouldReturn() -> String? {
        if let t = validateText() {
            return t
        }
        return nil
    }
}
