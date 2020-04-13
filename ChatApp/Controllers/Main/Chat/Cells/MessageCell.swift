//
//  ChatCell.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/3/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // MARK: - Properties
    /// Presenter
    var presenter: MessageCellPresenter? { didSet { presenter?.updateCell() } }
    
    /// IBOutlet properties
    @IBOutlet weak var memberNameLabel: UILabel?
    @IBOutlet weak var memberLabel: UILabel?
    @IBOutlet weak var currentUserLabel: UILabel?
    
    // MARK: - Deinitialization
    deinit { debugPrint("MessageCell Deinitialized") }
    
    // MARK: - Methods
    /// Override methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// Other methods
    func setMessage(_ labelToHide: UILabel?, _ labelToShow: UILabel?) {
        labelToHide?.text = ""
        labelToHide?.isHidden = true
        labelToShow?.isHidden = false
        labelToShow?.text = presenter?.message.text
        
        if let name = presenter?.message.sender?.name,
            (currentUserLabel?.isHidden ?? false),
            (presenter?.group ?? false)
        {
            memberNameLabel?.text = (presenter?.group ?? false) ? name : ""
        } else {
            memberNameLabel?.text = ""
        }
    }
}
