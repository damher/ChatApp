//
//  MenuViewController.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/25/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: - Properties
    /// Presenter
    var presenter: MenuViewPresenter?
    
    /// Main view controller
    private weak var main: UINavigationController?
    
    /// IBOutlet properties
    @IBOutlet weak var content: GradientView?
    @IBOutlet weak var tableView: UITableView? { didSet { configureTableView() }}
    @IBOutlet weak var menuWidth: NSLayoutConstraint? {
        didSet {
            let device = UIDevice.current.userInterfaceIdiom
            let screen = UIScreen.main.bounds
            menuWidth?.constant = device == .pad ? screen.width / 2 : screen.width / 4 * 3
        }
    }
    
    /// Gesture Direction
    private var tap: Bool = false
    
    // MARK: - Initialization
    static func instance(items: [MenuItem]) -> MenuViewController? {
        let vc = MenuViewController(nibName: "\(MenuViewController.self)", bundle: nil)
        vc.presenter = MenuViewPresenter(view: vc, items: items)
        return vc
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.reloadTableView()
    }
    
    // MARK: - Methods
    /// Configurations
    func config(_ controller: UINavigationController) {
        main = controller
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        panGestureRecognizerConfig()
    }
    
    /// Show and hide menu
    func showMenu() {
        main?.present(self, animated: false, completion: { [weak self] in
            if let width = self?.menuWidth?.constant {
                self?.content?.frame.origin.x = -width
            }
            self?.showMenu(with: 0.4)
        })
    }
    
    func showMenu(with duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.presenter?.show()
        }
        presenter?.isOpen = true
    }
    
    private func presentMenuVC() {
        main?.present(self, animated: false, completion: { [weak self] in
            if let width = self?.menuWidth?.constant {
                self?.content?.frame.origin.x = -width
            }
        })
    }
    
    func hideMenu(with duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.presenter?.hide()
        }) { _ in
            self.dismiss(animated: false)
        }
        presenter?.isOpen = false
    }
    
    // MARK: - Actions
    @IBAction func logout(_ sender: UIButton) {
        presenter?.logout()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView
    private func configureTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 44
        tableView?.register(UINib(nibName: "\(MenuHeaderCell.self)", bundle: nil),
                            forCellReuseIdentifier: "\(MenuHeaderCell.self)")
        tableView?.register(UINib(nibName: "\(MenuCell.self)", bundle: nil),
                            forCellReuseIdentifier: "\(MenuCell.self)")
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.menuItems.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(MenuHeaderCell.self)") as! MenuHeaderCell
            cell.dismiss = hideMenu
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(MenuCell.self)") as! MenuCell
            cell.titleLabel?.text = presenter?.menuItems[indexPath.row - 1].title
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = main?.viewControllers.first
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if indexPath.row > 1 {
                if let itemController = self.presenter?.menuItems[indexPath.row - 1].controller {
                    itemController.modalPresentationStyle = .overCurrentContext
                    itemController.modalTransitionStyle = .crossDissolve
                    vc?.present(itemController, animated: true)
                }
            }
        }
        hideMenu(with: 0.4)
    }
}

extension MenuViewController {
    
    // MARK: - Menu gesture recognizer
    private func panGestureRecognizerConfig() {
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panAction))
        pan.edges = .left
        main?.view.addGestureRecognizer(pan)
    }
    
    @objc private func panAction(_ sender: UIScreenEdgePanGestureRecognizer) {
        switch sender.state {
        case .began:
            presenter?.lastPoint = sender.location(in: main?.view).x.toFloat()
            presentMenuVC()
        case .changed:
            presenter?.gesturesMoved(sender.location(in: main?.view).x.toFloat())
        default:
            presenter?.gesturesEnded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tap = true
        if let point = touches.first?.location(in: main?.view).x.toFloat() {
            presenter?.lastPoint = point
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        tap = false
        if let point = touches.first?.location(in: main?.view).x.toFloat() {
            presenter?.gesturesMoved(point)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tap {
            hideMenu(with: 0.4)
        } else {
            presenter?.gesturesEnded()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tap {
            hideMenu(with: 0.4)
        } else {
            presenter?.gesturesEnded()
        }
    }
}
