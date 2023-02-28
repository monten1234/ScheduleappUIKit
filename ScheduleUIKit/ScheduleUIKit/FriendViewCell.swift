//
//  FriendViewCell.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/28.
//

import UIKit

class FriendViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    
    func setUserName(userName: String) {
        self.userName.text = userName
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
