//
//  ChatRouter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/21/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation
import Alamofire

enum ChatRouter: Router {
    case single(id: String)
    case group(name: String)
    case invite(id: String, u_id: String)
    
    //MARK: - HTTP method
    var method: HTTPMethod {
        switch self {
        case .invite:
            return .put
        default:
            return .post
        }
    }
    
    //MARK: - Path
    var path: String {
        switch self {
        case .single:
            return "/chats"
        case .group:
            return "/chats/group"
        case .invite:
            return "/chats/invite"
        }
    }
    
    //MARK: - Query parameters
    var queryParameters: [String: String]? {
        switch self {
        case .single(let id):
            return [Constant.Key.id: id]
        case .invite(let c_id, let u_id):
            return ["c_id": c_id, "u_id": u_id]
        default:
            return nil
        }
    }
    
    //MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .group(let name):
            return [Constant.Key.name: name, Constant.Key.group: true]
        default:
            return [Constant.Key.group: false]
        }
    }
}
