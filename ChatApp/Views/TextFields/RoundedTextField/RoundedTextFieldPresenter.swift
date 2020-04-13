//
//  RoundedTextFieldPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/9/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

class RoundedTextFieldPresenter {
    
    // MARK: - Nested types
    enum UIState {
        case normal
        case warning
        case editing
    }
    
    // MARK: - Properties
    /// View
    weak var view: RoundedTextField?
    
    /// Other properties
    var uiState: UIState = .normal {
        didSet { view?.updateState() }
    }
    
    // MARK: - Initialization
    required init(view: RoundedTextField) {
        self.view = view
    }
    
    // MARK: - Methods
    func setWarning() {
        uiState = .warning
    }
    
    func beginEditing() {
        uiState = .editing
    }
    
    func endEditing() {
        uiState = .normal
    }
    
    func valueChanged() {
        uiState = .editing
    }
}
