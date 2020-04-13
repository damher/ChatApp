//
//  PopupViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/27/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var nameTextField: RoundedTextField?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeybordNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeybordNotification()
    }
    
    // MARK: - Keybord notifications
    override func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView?.contentInset.bottom = keyboardSize.height
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        scrollView?.contentInset.bottom = 0
    }
    
    // MARK: - Methods
    func setTitle(_ title: String) {
        titleLabel?.text = title
    }
    
    // MARK: - Actions
    @IBAction func cencelButtonIsClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func okButtonIsClicked(_ sender: UIButton) {}
}
