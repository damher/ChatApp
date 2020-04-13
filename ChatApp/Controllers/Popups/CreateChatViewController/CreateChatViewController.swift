//
//  CreateChatViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/27/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class CreateChatViewController: PopupViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: CreateChatViewPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CreateChatViewPresenter(view: self)
        setTitle("CREATE CHAT")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateView()
    }
    
    // MARK: - Methods
    override func okButtonIsClicked(_ sender: UIButton) {
        super.okButtonIsClicked(sender)
        presenter?.createChat()
    }
    
    func navigation(_ chat: Chat?) {
        if let nav = self.presentingViewController as? MainNavigationController {
            let sb = UIStoryboard(name: UIStoryboard.Name.main, bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: UIStoryboard.Identity.chat) as! ChatViewController
            
            guard let c = chat else { return }
            vc.presenter = ChatViewPresenter(view: vc, chat: c)
            nav.pushViewController(vc, animated: true)
            self.dismiss(animated: false)
        }
    }
}
