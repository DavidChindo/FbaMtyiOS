//
//  MessagesViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/20/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
class MessagesViewController: BaseViewController,ChatDelegate  {
    
    @IBOutlet weak var messagesTableView: UITableView!

    var chatDataSource: ChatDataSource?
    var mMessages: [MessageResponse] = []
    var chatPresenter: ChatPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
        self.navigationItem.title = "Chat"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
        
        }

    func initViews(){
        chatPresenter = ChatPresenter(delegate: self)
        setupPresenter(chatPresenter!)
        
        chatDataSource = ChatDataSource(tableView: messagesTableView, items: mMessages)
        
        self.messagesTableView.delegate = chatDataSource
        self.messagesTableView.dataSource = chatDataSource
        
        
        // Self-sizing magic!
        //self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        //self.messagesTableView.estimatedRowHeight = 85; //Set this to any value that works for you.

        
        SwiftSpinner.show("Cargando...")
        chatPresenter?.messages(idHolding: (MenuViewController.holdingResponse?.Id)!)
    }

    func onErrrorMessages(msg: String?) {
        
    }
    
    func onErrorSentMessage(msg: String?) {
        
    }
    
    func onSuccessSentMessage(isSent: Bool) {
        
    }
    
    func onValid(isValid: Bool, msg: String?) {
        
    }
    
    func onLoadMessages(messages: [MessageResponse]) {
        mMessages = messages
        chatDataSource?.update(messages)
        SwiftSpinner.hide()
    }
    
    func dissmissView(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
}
