//
//  Router.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation
import Alamofire

protocol Router {
    // HTTPMethod
    var method: HTTPMethod { get }
    // Path
    var path:  String { get }
    // Parameters
    var parameters: Parameters? { get }
    // Query parameters
    var queryParameters: [String: String]? { get }
}
