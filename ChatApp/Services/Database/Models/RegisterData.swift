//
//  RegisterData.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/27/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation

struct RegisterData: Codable {
    
    enum CodingKeys: CodingKey {
        case name
        case email
        case password
        case token
        case authorized
        case logged
        case image
    }
    
    var name: String
    var email: String
    var password: String
    var token: String?
    var authorized: Bool?
    var logged: Bool?
    var image: Data?
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        token = try container.decode(String.self, forKey: .token)
        authorized = try container.decode(Bool.self, forKey: .authorized)
        logged = try container.decode(Bool.self, forKey: .logged)
        image = try container.decode(Data.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(token, forKey: .token)
        try container.encode(authorized, forKey: .authorized)
        try container.encode(logged, forKey: .logged)
        try container.encode(image, forKey: .image)
    }
}
