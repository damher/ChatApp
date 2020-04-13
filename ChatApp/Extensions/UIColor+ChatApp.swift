//
//  UIColor+ChatApp.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

extension UIColor {
    
    var colorImage: UIImage? {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIColor {
    
    static let textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    static let placeholderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
    static let viewFlipside = UIColor(red: 31/255, green: 33/255, blue: 36/255, alpha: 1)
}
