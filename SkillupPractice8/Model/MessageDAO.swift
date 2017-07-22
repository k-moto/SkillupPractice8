//
//  MessageDAO.swift
//  SkillupPractice8
//
//  Created by k_motoyama on 2017/07/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import RealmSwift

final class MessageDAO {
    
    static let dao = RealmDaoHelper<MessageData>()
    
    static func add(model: MessageData) {
        
        let object = MessageData()
        object.id = MessageDAO.dao.newId()!
        object.message = model.message
        object.createDate = model.createDate
        object.updateDate = model.updateDate
        
        MessageDAO.dao.add(d: object)
    }
    
    static func update(model: MessageData) {
        
        guard let object = dao.findFirst(key: model.id as AnyObject) else {
            return
        }
        
        
        _ = dao.update(d: object,block:{() -> Void in
            object.message = model.message
            object.updateDate = model.updateDate
        })
        
        
    }
    
    static func delete(id: Int) {
        
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return
        }
        dao.delete(d: object)
    }
    
    static func deleteAll() {
        dao.deleteAll()
    }
    
    static func findByID(id: Int) -> MessageData? {
        guard let object = dao.findFirst(key: id as AnyObject) else {
            return nil
        }
        return object
    }
    
    static func findFilter(predicate: NSPredicate) -> [MessageData]  {
        return dao.findFilter(predicate: predicate).map { MessageData(value: $0) }
        
    }
    
    static func findAll() -> [MessageData] {
        let objects =  MessageDAO.dao.findAll()
        return objects.map { MessageData(value: $0) }
    }
}
