//
//  ChatDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/20/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class ChatDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
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
            let cell:ChatUserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatUserCell") as! ChatUserTableViewCell
            
            cell.msgLbl.text = item.message
        // UIColor(red: 92/255, green: 193/255, blue: 220/255, alpha: 1)
        DesignUtils.setBorderRaidous(txtView: cell.msgLbl, mred: 92, mgreen: 193, mblue: 220)
            
            /*cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
 */
            return cell
            
        }else{
            let cell:ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "chatFBCell") as! ChatTableViewCell
            
            cell.messageLbl.text = item.message
            DesignUtils.setBorderRaidous(txtView: cell.messageLbl, mred: 92, mgreen: 193, mblue: 220)
        
            //cell.messageLbl.sizeToFit()
        
            /*cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
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

