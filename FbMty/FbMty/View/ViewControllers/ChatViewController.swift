//
//  ChatViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/13/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner


class ChatViewController: BaseViewController,ChatDelegate {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var containerInput: UIView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var inputTxtView: UITextView!
    
    var mMessages: [MessageResponse] = []
    var chatPresenter: ChatPresenter?
    var messageDataSource: MessageDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.navigationItem.title = "Chat"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
    }
    
    func initViews(){
        chatPresenter = ChatPresenter(delegate: self)
        setupPresenter(chatPresenter!)
        
        messageDataSource = MessageDataSource(tableView: chatTableView, items: mMessages)
        
        chatTableView.delegate = messageDataSource
        chatTableView.dataSource = messageDataSource
        
        SwiftSpinner.show("Cargando...")
        chatPresenter?.messages(idHolding: (MenuViewController.holdingResponse?.Id)!)
    }
    
    @IBAction func onSendMessageClick(_ sender: Any) {
        chatPresenter?.valid(field: inputTxtView)
    }

    func onLoadMessages(messages: [MessageResponse]) {
        messageDataSource?.update(messages)
        SwiftSpinner.hide()
    }
    
    
    func onErrrorMessages(msg: String?) {
        SwiftSpinner.hide()
    }
    
    func onValid(isValid: Bool, msg: String?) {
        if isValid {
            chatPresenter?.chatSent(msg: inputTxtView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), idHolding: (MenuViewController.holdingResponse?.Id)!)
            inputTxtView.text = ""
        }else{
            DesignUtils.messageError(vc: self, title: "Validación", msg: msg!)
        }
        
    }
    
    func onSuccessSentMessage(isSent: Bool) {
        if isSent{
            SwiftSpinner.show("Cargando...")
            chatPresenter?.messages(idHolding: (MenuViewController.holdingResponse?.Id)!)
        }
    }
    
    func onErrorSentMessage(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.messageError(vc: self, title: "Error", msg: msg!)
    }
    
    func dissmissView(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }

}
