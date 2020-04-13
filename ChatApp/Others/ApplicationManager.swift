//
//  ApplicationManager.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/29/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

struct ApplicationManager {
    static let shared = ApplicationManager()
    private init() {}
    
    func autoLogin() {
        if let _ = User.current {
            WSTaskManager.shared.open()
            changeRoot(storyBoardName: "Main", indetity: "navigation")
        }
    }
    
    private func changeRoot(storyBoardName: String, indetity: String? = nil) {
        let window = UIApplication.shared.windows.first
        let sb = UIStoryboard.init(name: storyBoardName, bundle: nil)
        let vc = indetity != nil ?
            sb.instantiateViewController(withIdentifier: indetity!) :
            sb.instantiateInitialViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func logout() {
        let window = UIApplication.shared.windows.first
        let sb = UIStoryboard(name: UIStoryboard.Name.authorizations, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: UIStoryboard.Identity.start)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
