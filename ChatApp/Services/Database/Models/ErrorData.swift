//
//  ErrorData.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/27/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

struct ErrorData: Error, Codable {
    
    enum CodingKeys: String, CodingKey {
        case error
        case reason
    }
    
    var error: Bool
    var reason: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        error = try container.decode(Bool.self, forKey: .error)
        reason = try container.decode(String.self, forKey: .reason)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(error, forKey: .error)
        try container.encode(reason, forKey: .reason)
    }
}
