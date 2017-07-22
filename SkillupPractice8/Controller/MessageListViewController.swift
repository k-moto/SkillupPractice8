//
//  MessageListViewController.swift
//  SkillupPractice8
//
//  Created by k_motoyama on 2017/07/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import UIKit

class MessageListViewController: UIViewController {
    
    @IBOutlet weak var inputText: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageList: UITableView!
    
    let messageListDataSource = MessageListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "メッセージ"

        messageList.dataSource = messageListDataSource
        messageList.estimatedRowHeight = 100
        messageList.rowHeight = UITableViewAutomaticDimension
        reloadTableData()
        
        inputText.delegate = self
        sendButton.isEnabled = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardClose(sender:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let notification = NotificationCenter.default
        notification.removeObserver(self)
        
    }
    
    func keyboardClose(sender: UITapGestureRecognizer) {
        inputText.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform
            
        })
        
    }
    
    func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
        })
    }
    
    fileprivate func reloadTableData(){
        let messageData = MessageDAO.findAll()
        messageListDataSource.add(dataList: messageData)
        messageList.reloadData()

    }
    
    @IBAction func pushSendButton(_ sender: UIButton) {
        let sendMessageData = MessageData()
        sendMessageData.message = inputText.text
        sendMessageData.createDate = Date()
        sendMessageData.updateDate = Date()
        
        MessageDAO.add(model: sendMessageData)
        reloadTableData()
        
        sendButton.isEnabled = false
        inputText.text = ""
        inputText.resignFirstResponder()
        
    }
    
}

extension MessageListViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        sendButton.isEnabled = textView.text.characters.count != 0
    }
    
}

