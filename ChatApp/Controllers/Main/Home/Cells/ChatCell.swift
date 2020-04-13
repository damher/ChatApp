//
//  UserCell.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/3/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import UIKit

class ChatCell: ShadowCell {
    
    // MARK: - Properties
    /// Presenter
    var presenter: ChatCellPresenter? {
        didSet {
            setImage()
            presenter?.updateCell()
        }
    }
    
    // MARK: - Deinitialization
    deinit { debugPrint("ChatCell Deinitialized") }
    
    /// IBOutlet properties
    @IBOutlet weak var imgView: Avatar?
    @IBOutlet weak var senderLabel: UILabel?
    @IBOutlet weak var lastMessageLabel: UILabel?
    @IBOutlet weak var countLabel: PaddingLabel?
    
    // MARK: - Methods
    override func draw(_ rect: CGRect) {
        
    }
    /// Override methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// Private methods
    private func setImage() {
        if let imgData = presenter?.chat?.members?.first?.image {
            imgView?.image = UIImage(data: imgData)
            
        } else {
            if let size = imgView?.frame.size {
                if let c = presenter?.chat?.unread_count {
                    let background: UIColor = c == 0 ? .white : .systemRed
                    let tint: UIColor = c == 0 ? .systemRed : .white
                    let char = presenter?.chat?.name?.first?.uppercased() ??
                        (presenter?.chat?.members?.first?.name?.first?.uppercased() ?? "?")
                    imgView?.image = UIImage.createWithText(size, char, tint, background)
                }
            }
        }
    }
}
