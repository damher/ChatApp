//
//  MenuViewPresenter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 3/3/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

class MenuViewPresenter {
    
    // MARK: - Properties
    /// View
    weak var view: MenuViewController?
    
    /// Items
    var menuItems = [MenuItem]()
    
    /// Private properties
    private var selectedIndexPath = IndexPath(item: 1, section: 0)
    
    /// Other properties
    var isOpen: Bool = false
    var lastPoint: Float = 0
    
    // MARK: - Initialization
    required init(view: MenuViewController, items: [MenuItem]) {
        self.view = view
        self.menuItems = items
    }
    
    func reloadTableView() {
        view?.tableView?.reloadData()
        view?.tableView?.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
    }
    
    func hide() {
        if let width = view?.menuWidth?.constant {
            view?.content?.frame.origin.x = -width
            view?.view.layoutIfNeeded()
            changeAlpha(menu: -width.toFloat())
        }
    }
    
    func show() {
        view?.content?.frame.origin.x = 0
        view?.view.layoutIfNeeded()
        changeAlpha(menu: 0)
    }
    
    func gesturesMoved(_ point: Float) {
        let movedDistance = point - lastPoint
        move(distance: movedDistance)
        lastPoint = point
    }
    
    func gesturesEnded() {
        guard let originX = view?.content?.frame.origin.x,
        let width = view?.menuWidth!.constant else { return }
        
        if originX > -width / 2 {
            view?.showMenu(with: 0.2)
        } else {
            view?.hideMenu(with: 0.2)
        }
    }
    
    func move(distance: Float) {
        guard let originX = view?.content?.frame.origin.x,
        let width = view?.menuWidth?.constant else { return }
        let newPoint = originX.toFloat() + distance
        
        if isOpen {
            if originX <= 0 && originX > -width {
                if newPoint <= 0 {
                    view?.content?.frame.origin.x = newPoint.toCGFloat()
                    changeAlpha(menu: newPoint)
                }
            } else {
                if originX > 0 {
                    view?.content?.frame.origin.x = 0
                    isOpen = true
                } else {
                    view?.content?.frame.origin.x = -width
                    isOpen = false
                    changeAlpha(menu: -width.toFloat())
                    view?.dismiss(animated: false)
                }
            }
        } else {
            if originX < 0 {
                view?.content?.frame.origin.x = newPoint.toCGFloat()
                changeAlpha(menu: newPoint)
            } else {
                view?.content?.frame.origin.x = 0
                isOpen = true
            }
        }
    }
    
    func changeAlpha(menu position: Float) {
        guard let width = view?.menuWidth?.constant.toFloat() else { return }
        
        if position <= 0 {
            let alpha = 0.5 - 0.5 / (width / -position)
            view?.view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: alpha.toCGFloat())
        }
    }
    
    func logout() {
        UserRequests.logout(success: { _ in
            UserDefaultsManager.token = nil
            UserDefaultsManager.password = nil
            CoreDataWrapper.shared.deleteAll()
            ApplicationManager.shared.logout()
        }) { error in
            self.view?.showAlertWith(title: Constant.Alert.error, message: error.description)
        }
    }
}
