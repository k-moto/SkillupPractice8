//
//  MessageListDataSource.swift
//  SkillupPractice8
//
//  Created by k_motoyama on 2017/07/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit
import STV_Extensions

class MessageListDataSource: NSObject, UITableViewDataSource {
    
    var dataList: [MessageData] = []
    var messageSectionData: MessageSectionData!
    let dispDateFormat = "yyyy-MM-dd"
    
    func add(dataList: [MessageData]){
        self.dataList = dataList.sorted(by: { $0.updateDate < $1.updateDate })
        messageSectionData = MessageSectionData(dataList: self.dataList)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageSectionData.sectionDateArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return messageSectionData.sectionDateArray[section].toStr(dateFormat: dispDateFormat)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = getSectionData(section: section)
        
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageListViewCell.identifier,for: indexPath) as! MessageListViewCell
        let sectionData = getSectionData(section: indexPath.section)[indexPath.row]
        cell.messageData = sectionData
        
        return cell
    }
    
    private func getSectionData(section: Int) -> [MessageData] {
        return dataList.filter{ $0.updateDate.toStr(dateFormat: dispDateFormat) == messageSectionData.sectionDateArray[section].toStr(dateFormat: dispDateFormat) }
        
    }
    
}
