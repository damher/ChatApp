//
//  AFRouter.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation
import Alamofire

struct AFRouter: URLRequestConvertible {
    
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func asURLRequest() throws -> URLRequest {
        // String URL
        let urlString = Constant.BaseURL.http + router.path
        
        // URL components
        var urlComponent = URLComponents.init(string: urlString) ?? URLComponents.init()
        
        // Query items
        let queryItems = router.queryParameters?.map({ (arg0) -> URLQueryItem in
            let (key, value) = arg0
            return URLQueryItem(name: key, value: value)
        })
        urlComponent.queryItems = queryItems
        
        // URL
        let url = try? urlComponent.url?.asURL()
        
        // Request
        var urlRequest =  URLRequest(url: url!)
        
        // HTTP Method
        urlRequest.httpMethod = router.method.rawValue
        
        // Common headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // User headers
        if let _ = User.current {
            urlRequest.setValue(UserDefaultsManager.token, forHTTPHeaderField: Constant.Key.token)
            urlRequest.setValue((User.current?.id)!, forHTTPHeaderField: Constant.Key.id)
        }
        
        // Parameters
        if let parameters = router.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return urlRequest
    }
}
