//
//  UserCell.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/6/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class UserCell: ShadowCell {

    // MARK: - Properties
    /// Presenter
    var presenter: UserCellPresenter? { didSet { presenter?.updateCell() }}
    
    /// IBOutlet properties
    @IBOutlet weak var imgView: Avatar?
    
    // MARK: - Deinitialization
    deinit { debugPrint("UserCell Deinitialized") }
    
    // MARK: - Methods
    /// Override methods
    override func layoutSubviews() {
        super.layoutSubviews()
        setImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// Private methods
    private func setImage() {
        imgView?.color = .systemRed
        if let user = presenter?.user {
            if let imgData = user.image {
                imgView?.image = UIImage(data: imgData)
                
            } else {
                if let size = imgView?.frame.size {
                    let background: UIColor = .white
                    let tint: UIColor = .systemRed
                    let char = String(user.name?.first?.uppercased() ?? "?")
                    imgView?.image = UIImage.createWithText(size, char, tint, background)
                }
            }
        }
    }
}
