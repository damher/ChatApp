//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/28/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - Presenter
    /// Presenter
    var presenter: ChatViewPresenter?
    
    // MARK: - Properties
    /// IBOutlet properties
    @IBOutlet weak var tableView: UITableView? { didSet { configurTableView() }}
    @IBOutlet weak var messageField: MessageField?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var textViewConstraint: NSLayoutConstraint?
    
    // MARK: - Deinitialization
    deinit { debugPrint("ChatViewController Deinitialized") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateData()
        messageField?.heightConstraint = textViewConstraint
        if (presenter?.chat.group ?? false) { addBarButtonItem() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeybordNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeybordNotification()
        presenter?.readMessages()
    }
    
    // MARK: - Keyboard notifications
    override func keyboardWillShow(_ notification: Notification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            guard let keyWindow = UIApplication.shared.windows.first else { return }
            bottomConstraint?.constant = -keyboardRect.height + keyWindow.safeAreaInsets.bottom
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        bottomConstraint?.constant = 0
    }
    
    // MARK: - Methods
    private func addBarButtonItem() {
        let btn = UIBarButtonItem.init(image: UIImage(systemName: "person.badge.plus.fill"),
                                       style: .done,
                                       target: self,
                                       action: #selector(addMember))
        btn.tintColor = .viewFlipside
        navigationItem.rightBarButtonItem = btn
    }
    
    // MARK: - Actions
    @IBAction func sendMessage(_ sender: RoundedButton) {
        if let text = messageField?.validateText() {
            presenter?.sendMessage(text)
            view.endEditing(true)
            messageField?.messageIsSent()
        }
    }
    
    @objc private func addMember() {
        let sb = UIStoryboard(name: UIStoryboard.Name.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: UIStoryboard.Identity.users) as! UsersViewController
        vc.presenter = UsersViewPresenter(view: vc, invitationId: presenter?.chat.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configurTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(UINib(nibName: "\(MessageCell.self)", bundle: nil),
                            forCellReuseIdentifier: "\(MessageCell.self)")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.rowsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MessageCell.self)") as! MessageCell
        guard let message = presenter?.messages[indexPath.row] else { return cell }
        cell.presenter = MessageCellPresenter(cell, message: message, group: (presenter?.chat.group ?? false))
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
}
