//
//  MessagesConsViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/21/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner

class MessagesConsViewController: BaseViewController,ChatDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    var mMessages: [MessageResponse] = []
    var chatPresenter: ChatPresenter?

    var messageTableCell = "MessagesCellId"
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    
    }

    //MARK: Setup Views
    func initViews(){
        chatPresenter = ChatPresenter(delegate: self)
        setupPresenter(chatPresenter!)
        
        SwiftSpinner.show("Cargando...")
        chatPresenter?.messages(idHolding: (MenuViewController.holdingResponse?.Id)!)
        
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        messagesTableView.estimatedRowHeight = 25
    }

    //MARK: Table Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: messageTableCell, for: indexPath) as! MessagesTableViewCell
        
        let item = mMessages[indexPath.row]
        
        cell.messageLbl.text = item.message        
        
        if !item.isResponse {
            cell.messageLbl.textAlignment = .right
            cell.messageLbl.backgroundColor = DesignUtils.colorPrimary
            cell.messageLbl.textColor = UIColor.white
        }
        
        return cell
    }
    
    func onLoadMessages(messages: [MessageResponse]) {
        mMessages = messages
        messagesTableView.reloadData()
        SwiftSpinner.hide()
    }
    
    func onValid(isValid: Bool, msg: String?) {
        
    }
    func onSuccessSentMessage(isSent: Bool) {
        
    }
    
    func onErrorSentMessage(msg: String?) {
        
    }
    func onErrrorMessages(msg: String?) {
        SwiftSpinner.hide()
    }
}
