//
//  LoadingView.swift
//  ChatApp
//
//  Created by Mher Davtyan on 11/26/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - Properties
    /// IBOutlet properties
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    /// Static properties
    static var shared: LoadingView {
        return UINib.init(nibName: "\(LoadingView.self)", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? LoadingView ?? LoadingView.init()
    }
    
    // MARK: - Methods
    /// Override methods
    override func didMoveToSuperview() {
        guard let superview_ = superview else { return }
        superview_.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["loading": self]
        
        superview_.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[loading]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: viewDict))
        superview_.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[loading]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: viewDict))
        superview_.bringSubviewToFront(self)
    }
    
    /// Other methods
    func show()  {
        let keyWindow = (UIApplication.shared.windows.filter {$0.isKeyWindow}).first
        DispatchQueue.main.async { keyWindow?.addSubview(self) }
    }
    
    func remove() { self.removeFromSuperview() }
}
