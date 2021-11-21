//
//  TableViewCell.swift
//  FlashChatMessenger
//
//  Created by Puja Kalpesh Surve on 21/11/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var viwMessageBuble: UIView!
    @IBOutlet weak var lblMsgLebel: UILabel!
    @IBOutlet weak var imgYou: UIImageView!
    @IBOutlet weak var imgMe: UIImageView!
    
    override func layoutSubviews() {
        viwMessageBuble.layer.cornerRadius = viwMessageBuble.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
