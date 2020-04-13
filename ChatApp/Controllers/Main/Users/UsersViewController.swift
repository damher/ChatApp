//
//  UsersViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/6/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: UsersViewPresenter?
    
    /// IBOutlet properties
    @IBOutlet weak var tableView: UITableView? { didSet { configurTableView() }}
    
    // MARK: - Deinitialization
    deinit { debugPrint("UsersViewController Deinitialized") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil { presenter = UsersViewPresenter(view: self) }
        presenter?.getUsers()
        configureSearchField()
    }
    
    // MARK: - Methods
    private func configureSearchField() {
        let device = UIDevice.current.userInterfaceIdiom
        let width = device == .pad ? view.frame.width / 1.1 : view.frame.width / 1.2
        let height = (navigationController?.navigationBar.frame.height ?? 60) / 1.3
        let searchBar = SearchTextField(frame: CGRect(origin: .zero,
                                                      size: CGSize(width: width,
                                                                   height: height)))
        searchBar.result = { [weak self] text in
            self?.presenter?.searchUsers(by: text)
        }
        
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.view.endEditing(true)
    }
    
    private func openChat(_ chat: Chat) {
        let sb = UIStoryboard(name: UIStoryboard.Name.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: UIStoryboard.Identity.chat) as! ChatViewController
        vc.presenter = ChatViewPresenter(view: vc, chat: chat)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configurTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 44
        tableView?.register(UINib(nibName: "\(UserCell.self)", bundle: nil),
                            forCellReuseIdentifier: "\(UserCell.self)")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.rowsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserCell.self)") as! UserCell
        let user = presenter?.users[indexPath.row]
        cell.presenter = UserCellPresenter(cell, user: user)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = presenter?.users[indexPath.row].id else { return }
        
        if presenter?.invitationId == nil {
            presenter?.createChat(id) { [weak self] chat in
                DispatchQueue.main.async {
                    self?.openChat(chat)
                }
            }
        } else {
            presenter?.addMember(id)
        }
    }
}
