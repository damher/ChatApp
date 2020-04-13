//
//  HomeViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/28/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: HomeViewPresenter?
    
    /// IBOutlet properties
    @IBOutlet weak var tableView: UITableView? { didSet { configurTableView() }}
    
    // MARK: - Deinitialization
    deinit { debugPrint("HomeViewController Deinitialized") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constant.Title.home
        presenter = HomeViewPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.updateData()
    }
    
    // MARK: - Actions
    @IBAction private func openMenu(_ sender: UIBarButtonItem) {
        if let nav = navigationController as? MainNavigationController {
            nav.openMenu()
        }
    }
    
    // MARK: - Navigation
    func openChat(_ chat: Chat) {
        let sb = UIStoryboard(name: UIStoryboard.Name.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: UIStoryboard.Identity.chat) as! ChatViewController
        vc.presenter = ChatViewPresenter(view: vc, chat: chat)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configurTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 44
        tableView?.register(UINib(nibName: "\(ChatCell.self)", bundle: nil),
                            forCellReuseIdentifier: "\(ChatCell.self)")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.rowsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ChatCell.self)") as! ChatCell
        let chat = presenter?.chats[indexPath.row]
        cell.presenter = ChatCellPresenter(cell, chat: chat)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chat = presenter?.chats[indexPath.row] else { return }
        openChat(chat)
    }
}
