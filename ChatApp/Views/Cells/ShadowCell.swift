//
//  ShadowCell.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/6/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class ShadowCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var content: GradientView?
    @IBOutlet weak var nameLabel: UILabel?
    
    // MARK: - Methods
    /// Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// Private methods
    private func addShadow() {
        content?.layer.cornerRadius = 10
        content?.layer.shadowColor = UIColor.black.cgColor
        content?.layer.shadowOffset = CGSize.zero
        content?.layer.shadowRadius = 3
        content?.layer.shadowOpacity = 0.1
    }
}
