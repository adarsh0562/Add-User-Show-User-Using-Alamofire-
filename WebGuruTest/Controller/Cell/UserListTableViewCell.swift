//
//  UserListTableViewCell.swift
//  WebGuruTest
//
//  Created by Adarsh Raj on 30/06/21.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.dropShadow()
    }

   
}

