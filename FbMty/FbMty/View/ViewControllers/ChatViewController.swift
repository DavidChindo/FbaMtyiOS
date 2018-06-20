//
//  ChatViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/13/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
import SnapKit


class ChatViewController: BaseViewController,ChatDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var messageStack: UIStackView!
    @IBOutlet weak var containerStack: UIView!
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
        
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 900)
        containerStack.frame = CGRect(x: containerStack.frame.origin.x, y: containerStack.frame.origin.y, width: containerStack.frame.width, height: 900)
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
        //messageDataSource?.update(messages)
        mMessages = messages
        printMessages()
        messageStack.distribution = .equalSpacing
        
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: CGFloat(messageStack.frame.height + 10))
        containerStack.frame = CGRect(x: containerStack.frame.origin.x, y: containerStack.frame.origin.y, width: containerStack.frame.width, height: CGFloat(messageStack.frame.height + 10))
        
        /*messageStack.frame = CGRect(x: messageStack.frame.origin.x, y: messageStack.frame.origin.y, width: messageStack.frame.width, height: CGFloat(50 * messageStack.arrangedSubviews.count))*/
        
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
    
    func printMessages(){
        
        for message in mMessages {
            
            if !message.isResponse {
                messageStack.addArrangedSubview(messageTo(msg: message.message!))
            }else{
                messageStack.addArrangedSubview(messageFrom(msg: message.message!))
            }
        }
        
    }
    
    func messageFrom(msg: String)->UIView{
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-20, height: 40))
        let dot = UILabel(frame: CGRect(x: 0, y: 4, width: self.view.frame.width - 30, height: 15))
        dot.text =  "FibraMTY dice: "
        dot.textColor = UIColor.gray
        dot.font = UIFont(name: "HelveticaNeue", size: 13)
        
        let label = UITextView(frame: CGRect(x: 0, y: dot.frame.height + 8, width: view.frame.width - 18, height: 25))
        label.text = msg
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.textColor = UIColor.black
        
        label.sizeToFit()
        var frame = label.frame
        frame.size.height = label.contentSize.height
        label.frame = frame
        
        view.addSubview(dot)
        view.addSubview(label)
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: (label.frame.origin.y + label.frame.height + 8))
        DesignUtils.containerRound(content: view)
        
        return view
    }

    func messageTo(msg: String)->UIView{
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 43))
        
        let label = UITextView(frame: CGRect(x: self.view.frame.width / 2, y: 8, width: (self.view.frame.width / 2) - 10, height: 40))
        
        label.text = msg
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.textColor = UIColor.white
        label.backgroundColor = DesignUtils.colorPrimary
        label.sizeToFit()
        var frame = label.frame
        frame.size.height = label.contentSize.height
        label.frame = frame
        label.textAlignment = .right
        
        view.addSubview(label)
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: (label.frame.origin.y + label.frame.height + 8))
        let viewReturn =  DesignUtils.containerRoundWithReturn(content: view)
        viewReturn.backgroundColor = DesignUtils.colorPrimary
        return viewReturn
    }

}
