//
//  Avatar.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class Avatar: UIImageView {
    
    var color: UIColor = .systemRed {
        didSet {
            layer.borderColor = color.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        color = .systemRed
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.contentMode = .scaleAspectFill
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        clipsToBounds = true
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: bounds.width / 2)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
