//
//  CardCell.swift
//  AccountChain
//
//  Created by Emre Öztürk on 16.12.2023.
//

import UIKit

class CardCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var password: UIView!
    
    
    @IBOutlet weak var editIcon: UIImageView!
    @IBOutlet weak var removeIcon: UIImageView!
    @IBOutlet weak var emailCopyIcon: UIView!
    @IBOutlet weak var usernameCopyIcon: UIImageView!
    @IBOutlet weak var passwordCopyIcon: UIImageView!
    @IBOutlet weak var showPasswordIcon: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
