//
//  MessageListViewCell.swift
//  SkillupPractice8
//
//  Created by k_motoyama on 2017/07/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

final class MessageListViewCell: UITableViewCell {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var messageDate: UILabel!
    
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    var messageData: MessageData? {
        didSet {
            message.text = messageData?.message
            messageDate.text = messageData?.updateDate.toStr(dateFormat: "hh:mm")
            
        }
    }
}
