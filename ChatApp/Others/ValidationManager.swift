//
//  ValidationManager.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

struct ValidationManager {
    static var shared = ValidationManager()
    private init() {}
    
    func isValidEmail(_ testStr:String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPassword(_ testStr: String) -> Bool {
        if testStr.count < 6 || testStr.contains(" ") {
            return false
        }
        return true
    }
    
    func isSufficientChars(_ testStr: String) -> Bool {
        if testStr.count < 2 {
            return false
        }
        return true
    }
}
