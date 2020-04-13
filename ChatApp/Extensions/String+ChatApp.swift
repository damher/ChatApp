//
//  String+ChatApp.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/4/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import Foundation

extension String {
    
    func formatToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}
