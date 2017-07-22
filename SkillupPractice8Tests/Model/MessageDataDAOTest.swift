//
//  MessageDataDAOTest.swift
//  SkillupPractice8
//
//  Created by k_motoyama on 2017/06/24.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import STV_Extensions
import XCTest
@testable import SkillupPractice8

class MessageDataDAOTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        MessageDAO.deleteAll()

    }
    
    override func tearDown() {
        super.tearDown()
        MessageDAO.deleteAll()
    }
    
    func testAdd(){
        let object = MessageData()
        
        let createDate = "2016/01/01 10:00"
        let updateDate = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.message = "テストメッセージ1"
        object.createDate = createDate.toDate(dateFormat: format)
        object.updateDate = updateDate.toDate(dateFormat: format)
        
        MessageDAO.add(model:object)
        
        verifyItem(id: 1, message: "テストメッセージ1", createDateStr: createDate, updateDateStr: updateDate)
    }
    
    func testUpdate(){
        
        let object = MessageData()
        
        let createDate = "2016/01/01 10:00"
        let updateDate = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.message = "テストメッセージ1"
        object.createDate = createDate.toDate(dateFormat: format)
        object.updateDate = updateDate.toDate(dateFormat: format)
        
        MessageDAO.add(model:object)
        
        object.id = 1
        object.message = "テストメッセージ2"
        object.updateDate = "2016/01/01 20:30".toDate(dateFormat: format)
        
        MessageDAO.update(model:object)
        
        verifyItem(id: 1, message: "テストメッセージ2", createDateStr: createDate, updateDateStr: "2016/01/01 20:30")
    }
    
    func testDelete(){
        
        let object = MessageData()
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.message = "テストメッセージ1"
        object.createDate = startTime.toDate(dateFormat: format)
        object.updateDate = endTime.toDate(dateFormat: format)
        
        MessageDAO.add(model:object)
        
        MessageDAO.delete(id: 1)
        
        verifyCount(count:0)
    }
    
    func testFindByID(){
        
        let object = MessageData()
        
        let startTime = "2016/01/01 10:00"
        let endTime = "2016/01/01 18:30"
        let format = "yyyy/MM/dd HH:mm"
        
        object.id = 1
        object.message = "テストメッセージ1"
        object.createDate = startTime.toDate(dateFormat: format)
        object.updateDate = endTime.toDate(dateFormat: format)
        
        MessageDAO.add(model:object)
        
        let result = MessageDAO.findByID(id: 1)
        
        XCTAssertEqual(result?.id, 1)
    }
    
    func testFindAll(){
        
        let messages = [MessageData(),MessageData(),MessageData()]
        
        _ = messages.map {
            MessageDAO.add(model:$0)
        }
        
        verifyCount(count:3)
    }
    
    //MARK:-private method
    private func verifyItem(id: Int, message: String, createDateStr: String, updateDateStr: String) {
        
        let format = "yyyy/MM/dd HH:mm"
        
        let result = MessageDAO.findAll()
        
        XCTAssertEqual(result.first?.id, id)
        XCTAssertEqual(result.first?.message, message)
        XCTAssertEqual(result.first?.createDate.toStr(dateFormat: format), createDateStr)
        XCTAssertEqual(result.first?.updateDate.toStr(dateFormat: format), updateDateStr)
        
    }
    
    private func verifyCount(count: Int) {
        
        let result = MessageDAO.findAll()
        XCTAssertEqual(result.count, count)
    }
}
