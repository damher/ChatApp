//
//  RoundedTextField.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Presenter
    var presenter: RoundedTextFieldPresenter?
    
    /// IBInspectable properties
    @IBInspectable var border: CGFloat = 0 {
        didSet {
            layer.borderWidth = border
            layer.borderColor = UIColor.viewFlipside.cgColor
        }
    }
    
    // MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.presenter = RoundedTextFieldPresenter(view: self)
        self.delegate = self
        self.addTarget(self, action: #selector(changeValue), for: .editingChanged)
        self.configure()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(origin: CGPoint.init(x: 15, y: 0),
                           size: CGSize.init(width: bounds.size.width - 30,
                                             height: bounds.size.height))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect.init(origin: CGPoint.init(x: 15, y: 0),
                           size: CGSize.init(width: bounds.size.width - 30,
                                             height: bounds.size.height))
    }
    
    // MARK: - Methods
    /// Private methods
    private func configure() {
        self.borderStyle = .none
        self.layer.backgroundColor = backgroundColor?.cgColor
        self.layer.cornerRadius = 10
        self.textColor = .textColor
        let placeHolderText = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor])
    }
    
    /// Other methods
    func updateState() {
        var clr = UIColor.lightGray
        var placeholderClr = UIColor.placeholderColor
        
        switch presenter?.uiState {
        case .warning:
            clr = .systemRed
            placeholderClr = .systemRed
        case .editing:
            clr = UIColor.textColor
            placeholderClr = .placeholderColor
        default:
            clr = UIColor.textColor
            placeholderClr = .placeholderColor
        }
        textColor = clr
        let placeHolderText = placeholder ?? ""
        attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderClr])
    }
    
    // MARK: - Actions
    @objc func changeValue(_ textField: UITextField) {
        presenter?.valueChanged()
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: Int = textField.tag + 1
        let nextResponder: UIResponder? = textField.superview?.viewWithTag(nextTag)
        
        guard nextResponder is UITextField else {
            textField.resignFirstResponder()
            return false
        }
        
        if let nextR = nextResponder {
            nextR.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        presenter?.beginEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.endEditing()
    }
}
