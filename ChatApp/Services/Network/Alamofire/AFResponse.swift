//
//  AFResponse.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation
import Alamofire

struct AFResponse<Value> where Value : Decodable {
    
    var value: Value?
    var error: Error?
    
    var isSuccess: Bool = false
    
    init(data: DataResponse<Any>, decoder: JSONDecoder = JSONDecoder()) {
        switch data.result {
        case .success(let successData):
            do {
                if let dict = successData as? [String: Any] {
                    if dict["error"] != nil {
                        let a = try JSONSerialization.data(withJSONObject: successData, options: JSONSerialization.WritingOptions.prettyPrinted)
                        self.error = try JSONDecoder().decode(ErrorData.self, from: a)
                        isSuccess = false
                    } else {
                        let a = try JSONSerialization.data(withJSONObject: successData, options: JSONSerialization.WritingOptions.prettyPrinted)
                        self.value = try decoder.decode(Value.self, from: a)
                        isSuccess = true
                    }
                } else {
                    let a = try JSONSerialization.data(withJSONObject: successData, options: JSONSerialization.WritingOptions.prettyPrinted)
                    self.value = try decoder.decode(Value.self, from: a)
                    isSuccess = true
                }
            } catch {
                isSuccess = false
                self.error = error
            }
        case .failure(let error):
            self.error = error
            isSuccess = false
        }
    }
}
