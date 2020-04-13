//
//  Constant.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/11/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

struct Constant {
    struct Title {
        static let home = "Chat App"
    }
    
    struct Alert {
        static let verificationTitle = "Check Email"
        static let verificationMessage = "We sent mail verification link to your Email"
        static let error = "Error"
    }
    
    struct BaseURL {
        static let http = "http://localhost:8080"
        static let ws = "ws://localhost:8080"
    }
    
    struct Key {
        static let id = "id"
        static let token = "token"
        static let name = "name"
        static let email = "email"
        static let password = "password"
        static let group = "group"
    }
}
