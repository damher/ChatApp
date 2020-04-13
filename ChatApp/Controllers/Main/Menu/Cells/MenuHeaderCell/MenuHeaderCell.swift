//
//  MenuHeaderCell.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/25/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class MenuHeaderCell: UITableViewCell {

    @IBOutlet weak var avatarView: Avatar?
    @IBOutlet weak var titleLabel: UILabel?
    
    var dismiss: ((TimeInterval) -> Void)?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setImage()
        titleLabel?.text = User.current?.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setImage() {
        avatarView?.color = .white
        if let user = User.current {
            if let imgData = user.image {
                avatarView?.image = UIImage(data: imgData)
            } else {
                if let size = avatarView?.frame.size {
                    let background: UIColor = .systemRed
                    let tint: UIColor = .white
                    let char = String(user.name?.first?.uppercased() ?? "?")
                    avatarView?.image = UIImage.createWithText(size, char, tint, background)
                }
            }
        }
    }
    
    @IBAction func hideMenu(_ sender: UIButton) {
        dismiss?(1)
    }
}
