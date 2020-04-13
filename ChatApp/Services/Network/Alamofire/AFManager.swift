//
//  AFManager.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation
import Alamofire

struct AFManager {
    
    @discardableResult
    static func performRequest<Value: Decodable>(router: Router,
                                          decoder: JSONDecoder = JSONDecoder(),
                                          completion: @escaping (AFResponse<Value>)->Void) -> DataRequest {
        return SessionManager.default
            .request(AFRouter(router: router))
            .responseJSON { (response: DataResponse<Any>) in
            completion(AFResponse<Value>(data: response, decoder: decoder))
        }
    }
}
