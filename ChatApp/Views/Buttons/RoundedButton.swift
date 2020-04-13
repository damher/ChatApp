//
//  RoundedButton.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    // MARK: - Properties
    /// IBInspectable properties
    @IBInspectable var highlighedBackgroundColor: UIColor? = UIColor.white
    @IBInspectable var highlightedTitleColor: UIColor? = UIColor.white
    @IBInspectable var fullRounded: Bool = false
    
    /// Override properties
    override var isHighlighted: Bool {
        get { return super.isHighlighted }
        set {
            if newValue {
                self.setBackgroundImage(highlighedBackgroundColor?.colorImage, for: .highlighted)
                self.setTitleColor(highlightedTitleColor, for: .highlighted)
            }
            super.isHighlighted = newValue
        }
    }
    
    // MARK: - Methods
    /// Override methods
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateCornerRadius()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCornerRadius()
    }
    
    /// private methods
    private func updateCornerRadius() {
        self.clipsToBounds = true
        self.layer.cornerRadius = fullRounded ? self.frame.size.height/2 : 10.0
    }
}
