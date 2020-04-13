//
//  MessageField.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/3/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class MessageField: UITextView, UITextViewDelegate {
    
    // MARK: - Properties
    /// Presenter
    var presenter: MessageFieldPresenter?
    
    /// Private properties
    private var normalHeight: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 40 : 30
    }
    
    /// Override properties
    override var contentSize: CGSize {
        didSet { updateSize() }
    }
    
    /// Other properties
    var heightConstraint: NSLayoutConstraint?
    
    // MARK: - Methods
    /// Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        presenter = MessageFieldPresenter(view: self)
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 5
    }
    
    /// Private methods
    private func configureView() {
        self.delegate = self
        self.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.text = presenter?.placeholder
        self.textColor = .placeholderColor
        self.tintColor = .systemRed
    }
    
    /// Other methods
    func validateText() -> String? {
        return presenter?.validateText()
    }
    
    func messageIsSent() {
        presenter?.messageIsSent()
        textColor = UIColor.placeholderColor
    }
    
    func updateSize() {
        let size = contentSize.height < normalHeight * 3 ?
        contentSize.height : normalHeight * 3
        
        heightConstraint?.constant = size
        layoutIfNeeded()
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        presenter?.didBeginEditing()
        textColor = UIColor.textColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter?.didEndEditing()
        if let isWordPlaceholder = presenter?.placeholderIsWritten {
            if !isWordPlaceholder {
                textColor = UIColor.placeholderColor
            }
        }
    }
}
