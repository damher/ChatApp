//
//  UserRouter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter: Router {
    case all
    case search(name: String)
    case register(data: RegisterData)
    case login(email: String, password: String)
    case logout
    case changeName(name: String)
    case changePassword(password: String)
    
    //MARK: - HTTP method
    var method: HTTPMethod {
        switch self {
        case .all, .search:
            return .get
        case .register:
            return .post
        case .login, .logout, .changeName, .changePassword:
            return .put
        }
    }
    
    //MARK: - Path
    var path: String {
        switch self {
        case .all:
            return "/users"
        case .search:
            return "/search"
        case .register:
            return "/register"
        case .login:
            return "/login"
        case .logout:
            return "/logout"
        case .changeName:
            return "/users/name"
        case .changePassword:
            return "/users/change-password"
        }
    }
    
    //MARK: - Query parameters
    var queryParameters: [String: String]? {
        switch self {
        case .search(let name):
            return [Constant.Key.name: name]
        default:
            return nil
        }
    }
    
    //MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .register(let data):
            do { return try data.json() }
            catch { return nil }
        case .login(let email, let password):
            return [Constant.Key.email: email, Constant.Key.password: password]
        case .changeName(let name):
            return [Constant.Key.name: name]
        case .changePassword(let password):
            return [Constant.Key.password: password]
        default:
            return nil
        }
    }
}
