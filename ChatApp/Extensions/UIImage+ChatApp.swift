//
//  UIImage+ChatApp.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/13/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func create(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    class func createWithText(_ size: CGSize, _ text: String, _ tint: UIColor, _ background: UIColor) -> UIImage {
        let lbl = PaddingLabel(frame: CGRect(origin: .zero, size: size))
        lbl.textAlignment = .center
        lbl.text = text
        lbl.textColor = tint
        lbl.backgroundColor = background
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        lbl.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return img
    }
}
