//
//  ChatCollectionViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/20/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner

class ChatCollectionViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,ChatDelegate{

    @IBOutlet weak var chatCollection: UICollectionView!
    
    var mMessages: [MessageResponse] = []
    var chatPresenter: ChatPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
    }
    
    func initViews(){
        chatPresenter = ChatPresenter(delegate: self)
        setupPresenter(chatPresenter!)
        
        SwiftSpinner.show("Cargando...")
        chatPresenter?.messages(idHolding: (MenuViewController.holdingResponse?.Id)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = mMessages[indexPath.row]
        
       // if !item.isResponse {
        
            let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatUserId", for: indexPath) as! ChatUserCollectionViewCell
            
            collection.msgTxtView.text = item.message
            collection.msgTxtView.sizeToFit()
        
            var frame = collection.msgTxtView.frame
            frame.size.height = collection.msgTxtView.contentSize.height
            collection.msgTxtView.frame = frame
        
          /*  collection.msgTxtView.frame = CGRect(x: collection.msgTxtView.frame.origin.x, y: messageTxtViewTemp.frame.origin.y, width: messageTxtViewTemp.frame.width, height: (messageTxtViewTemp.frame.origin.y + messageTxtViewTemp.frame.height + 4))
        */
            //DesignUtils.txtViewRoundWithReturn(content: collection.msgTxtView)
            
            return collection
        
        /*}else{
    
            let collection = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatUserCollection", for: indexPath) as! ChatCollectionCollectionViewCell
            
            collection.msgCollTxtView.text = item.message
            
            
          //  DesignUtils.txtViewRoundWithReturn(content: collection.msgCollTxtView)
            
            return collection
        }*/
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mMessages.count
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
        chatCollection.delegate = self
        chatCollection.dataSource = self
        chatCollection.reloadSections(IndexSet(integer: 0))
        
        SwiftSpinner.hide()
    }


}
