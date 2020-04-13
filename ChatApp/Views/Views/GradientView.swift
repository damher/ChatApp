//
//  GradientView.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/12/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    // MARK: - Properties
    /// IBInspectable properties
    @IBInspectable var firstColor: UIColor = UIColor.clear { didSet { updateView() }}
    @IBInspectable var secondColor: UIColor = UIColor.clear { didSet { updateView() }}
    @IBInspectable var thirdColor: UIColor = UIColor.clear { didSet { updateView() } }
    @IBInspectable var isHorizontal: Bool = true { didSet { updateView() }}
    
    /// Override properties
    override class var layerClass: AnyClass { get { return CAGradientLayer.self }}
    
    // MARK: - Methods
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor, thirdColor].map {$0.cgColor}
        if (isHorizontal) {
            layer.startPoint = CGPoint(x: -0.4, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: -0.3)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
    }
}
