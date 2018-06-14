//
//  MessageDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/13/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class MessageDataSource:NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items: [MessageResponse] = []
    
    var emptyMessage = "No hay mensajes"
    
    init(tableView: UITableView,items: [MessageResponse] ) {
        self.tableView = tableView
        self.items = items
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if items.count > 0 {
            self.tableView?.backgroundView = nil
            return self.items.count
        }else{
            
            let messageLabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.tableView!.bounds.size.width, height: self.tableView!.bounds.size.height))
            messageLabel.text = emptyMessage
            messageLabel.textColor = UIColor.darkGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "Helvetic", size: 20)
            messageLabel.sizeToFit()
            self.tableView?.backgroundView = messageLabel;
            self.tableView?.separatorStyle = .none
            
            return 0
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.items[indexPath.row]
        
        if !item.isResponse{
        
            let cell:MessageSentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MessageSentCell") as! MessageSentTableViewCell
            //cellSent.containerMsgView.backgroundColor = DesignUtils.colorPrimary
            cell.messageSentTxtView.text = item.message
          /*  var messageTxtViewTemp = DesignUtils.txtViewRoundWithReturn(content: cell.messageSentTxtView)
            messageTxtViewTemp.backgroundColor = DesignUtils.colorPrimary
            messageTxtViewTemp.sizeToFit()
            var frame = messageTxtViewTemp.frame
            frame.size.height = messageTxtViewTemp.contentSize.height
            messageTxtViewTemp.frame = frame
            
            messageTxtViewTemp.frame = CGRect(x: messageTxtViewTemp.frame.origin.x, y: messageTxtViewTemp.frame.origin.y, width: messageTxtViewTemp.frame.width, height: (messageTxtViewTemp.frame.origin.y + messageTxtViewTemp.frame.height + 4))*/
            /*
 cellSent.messageSentTxtView.sizeToFit()
 var frame = cellSent.messageSentTxtView.frame
 frame.size.height = cellSent.messageSentTxtView.contentSize.height
 cellSent.messageSentTxtView.frame = frame
 
 cellSent.containerMsgView.frame = CGRect(x: cellSent.containerMsgView.frame.origin.x, y: cellSent.containerMsgView.frame.origin.y, width: cellSent.containerMsgView.frame.width, height: (cellSent.messageSentTxtView.frame.origin.y + cellSent.messageSentTxtView.frame.height + 4))
 
 */
            return cell
 
        }else{
            let cell:MessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "messageId") as! MessageTableViewCell
            cell.fromLbl.isHidden = false
            cell.messageTxtView.textColor = UIColor.black
            cell.contentMessage.backgroundColor = UIColor.white
            //DesignUtils.containerRound(content: cell.messageTxtView)
            cell.messageTxtView.text = item.message
            /*cell.messageTxtView.sizeToFit()
            var frame = cell.messageTxtView.frame
            frame.size.height = cell.messageTxtView.contentSize.height
            cell.messageTxtView.frame = frame
            
            cell.contentMessage.frame = CGRect(x: cell.contentMessage.frame.origin.x, y: cell.contentMessage.frame.origin.y, width: cell.contentMessage.frame.width, height: (cell.messageTxtView.frame.origin.y + cell.messageTxtView.frame.height + 4))
            */
            return cell

        }
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func update(_ items: [MessageResponse]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
}

