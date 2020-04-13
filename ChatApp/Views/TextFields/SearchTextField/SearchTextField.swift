//
//  SearchTextField.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/12/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class SearchTextField: UITextField, UITextFieldDelegate {

    // MARK: - Properties
    /// Presenter
    var presenter: SearchTextFieldPresenter?
    
    /// Callback properties
    var result: ((String) -> Void)?
    
    // MARK: - Methods
    /// Override methods
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        presenter = SearchTextFieldPresenter(view: self)
        delegate = self
        configureView()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(origin: CGPoint.init(x: 10, y: 0),
                           size: CGSize.init(width: bounds.size.width - 20,
                                             height: bounds.size.height))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(origin: CGPoint.init(x: 10, y: 0),
                           size: CGSize.init(width: bounds.size.width - 20,
                                             height: bounds.size.height))
    }

    /// Private methods
    private func configureView() {
        tintColor = UIColor.systemRed
        textColor = UIColor.viewFlipside
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.1
        borderStyle = .none
        returnKeyType = .search
        placeholder = "Search"
    }
    
    /// Other methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = presenter?.shouldReturn() {
            result?(searchText)
        }
        return true
    }
}
