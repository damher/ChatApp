//
//  PaddingLabel.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/4/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

@IBDesignable
class PaddingLabel: UILabel {
    
    // MARK: - Properties
    /// IBInspectable properties
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    @IBInspectable var firstColor: UIColor = UIColor.clear { didSet { updateView() }}
    @IBInspectable var secondColor: UIColor = UIColor.clear { didSet { updateView() }}
    @IBInspectable var thirdColor: UIColor = UIColor.clear { didSet { updateView() } }
    @IBInspectable var isHorizontal: Bool = true { didSet { updateView() }}
    
    /// Override properties
    override class var layerClass: AnyClass { get { return CAGradientLayer.self }}
    
    // MARK: - Methods
    /// Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    /// Private methods
    private func updateView() {
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
