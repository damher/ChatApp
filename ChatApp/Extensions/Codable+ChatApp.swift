//
//  Codable+ChatApp.swift
//  ChatApp
//
//  Created by Mher Davtyan on 1/23/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

extension Decodable {
    init(jsonDictionary: [String: Any]) throws {
        let decoder = JSONDecoder()
        let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
        self = try decoder.decode(Self.self, from: data)
    }
}

extension Encodable {
    func json() throws -> [String: Any]?  {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return jsonDict
        } catch {
            return nil
        }
    }
}
