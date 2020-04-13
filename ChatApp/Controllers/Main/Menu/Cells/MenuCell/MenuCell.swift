//
//  MenuCell.swift
//  ChatApp
//
//  Created by Mher Davtyan on 2/25/20.
//  Copyright © 2020 Mher Davtyan. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var selectView: UIView?
    @IBOutlet weak var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectView?.alpha = selected ? 1 : 0
    }
}
