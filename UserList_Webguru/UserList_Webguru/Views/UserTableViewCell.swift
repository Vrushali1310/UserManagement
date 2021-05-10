//
//  UserTableViewCell.swift
//  UserList_Webguru
//
//  Created by Vrushali Mahajan on 5/10/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(user: User, index: Int) {
        userNameLabel.text = user.name
        emailLabel.text = user.email
        mobileLabel.text = user.mobile
        indexLabel.text = "\(index)"
    }
}
