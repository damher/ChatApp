//
//  UserDefaultsManager.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

struct UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    struct Key {
        static let token = "token"
        static let password = "password"
    }
    
    static var password: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsManager.Key.password)
            UserDefaults.standard.synchronize()
        }
        
        get {
            if let password = UserDefaults.standard.value(forKey: UserDefaultsManager.Key.password) as? String {
                return password
            }
            return nil
        }
    }
    
    static var token: String? {
        set {
            if newValue != nil {
                UserDefaults.standard.setValue(newValue!, forKey: UserDefaultsManager.Key.token)
                UserDefaults.standard.synchronize()
            }
        }
        
        get {
            if let newToken = UserDefaults.standard.value(forKey: UserDefaultsManager.Key.token) as? String {
                return "\(newToken)"
            }
            return nil
        }
    }
    
    static func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsManager.Key.token)
        UserDefaults.standard.removeObject(forKey: UserDefaultsManager.Key.password)
        UserDefaults.standard.synchronize()
    }
}
