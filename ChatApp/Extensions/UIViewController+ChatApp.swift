//
//  UIViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

// MARK: - Keyboard Notifications
extension UIViewController {
    func addKeybordNotification() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeybordNotification() -> Void {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {}
    @objc func keyboardWillHide(_ notification: Notification) {}
}
