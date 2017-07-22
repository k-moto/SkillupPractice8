//
//  MessageData.swift
//  SkillupPractice8
//
//  Created by k_motoyama on 2017/07/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

class MessageData: Object {
    
    dynamic var id = 0
    dynamic var message = ""
    dynamic var createDate = Date()
    dynamic var updateDate = Date()
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
    
}
