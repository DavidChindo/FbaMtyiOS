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
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messagesTableView: UITableView!
    
    var mMessages: [MessageResponse] = []
    @IBOutlet weak var messageTxtView: UITextField!
    var chatPresenter: ChatPresenter?

    var messageTableCell = "MessagesCellId"
    var messageFbTableCell = "MessagesFbMty"
    
    var emptyMessage = "No hay mensajes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Chat"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
        

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
        if mMessages.count > 0 {
            self.messagesTableView?.backgroundView = nil
            return mMessages.count
        }else{
            
            let messageLabel = UILabel(frame: CGRect(x: 0,y: 0,width: messagesTableView!.bounds.size.width, height: messagesTableView!.bounds.size.height))
            messageLabel.text = emptyMessage
            messageLabel.textColor = UIColor.darkGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "Helvetic", size: 20)
            messageLabel.sizeToFit()
            messagesTableView?.backgroundView = messageLabel;
            messagesTableView?.separatorStyle = .none
            
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = mMessages[indexPath.row]
        
        if !item.isResponse {
            
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: messageTableCell, for: indexPath) as! MessagesTableViewCell
        
            cell.messageLbl.text = "  " + item.message! + "  "
            cell.messageLbl.sizeToFit()
            cell.messageLbl.textAlignment = .right
            cell.containerView.sizeToFit()
            cell.containerView.layer.cornerRadius = 5
            
            return cell
        }else{
        
            let cell = messagesTableView.dequeueReusableCell(withIdentifier: messageFbTableCell, for: indexPath) as!
            MessagesFbTableViewCell
            
            cell.messageFbLbl.text = "  " +  item.message! + "  "
            
            DesignUtils.setBorderLabel(button: cell.messageFbLbl)
            
            return cell
            
        }
        
        
    }
    
    //MARK: OnClicks
    
    @IBAction func onSendClick(_ sender: Any) {
        chatPresenter?.validTxtField(field: messageTxtView)
    }
    
    //MARK: Presenter Delegates
    func onLoadMessages(messages: [MessageResponse]) {
        mMessages = messages
        messagesTableView.reloadData()
        scrollToBottom()
        SwiftSpinner.hide()
    }
    
    func onValid(isValid: Bool, msg: String?) {
        if isValid {
            chatPresenter?.chatSent(msg: messageTxtView.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), idHolding: (MenuViewController.holdingResponse?.Id)!)
            messageTxtView.text = ""
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
   
    func onErrrorMessages(msg: String?) {
        SwiftSpinner.hide()
    }
    
    func dissmissView(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.mMessages.count-1, section: 0)
            self.messagesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
