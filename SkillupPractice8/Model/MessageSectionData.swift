//
//  MessageSectionData.swift
//  SkillupPractice8
//
//  Created by k_motoyama on 2017/07/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import STV_Extensions

class MessageSectionData {
    
    var dataList: [MessageData] = []
    var sectionDateArray: [Date] = []
    
    init(dataList: [MessageData]){
        self.dataList = dataList
        self.sectionDateArray = createSectionArray()
    }
    
    func createSectionArray() -> [Date] {
        var sectionDateArray: [Date] = []
        let dateFormat = "yyyy-MM-dd"
        
        for data in dataList {
            
            let dispDateStr = data.updateDate.toStr(dateFormat: dateFormat)
            let sameDate = sectionDateArray.filter{ $0.toStr(dateFormat: dateFormat) == dispDateStr }
            
            if sameDate.count == 0 {
                sectionDateArray.append(data.updateDate)
            }
        }
        
        return sectionDateArray
    }
    
}
