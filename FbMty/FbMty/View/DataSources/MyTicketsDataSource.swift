//
//  MyTicketsDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/18/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class MyTicketsDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items: [MyTicketResponse] = []
    var delegate:MyTicketsDelegate?
    
    var emptyMessage = "No hay datos"
    
    init(tableView: UITableView,items: [MyTicketResponse], delegate: MyTicketsDelegate) {
        self.tableView = tableView
        self.items = items
        self.delegate = delegate
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
        
        let cell:MyTicketsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTicketsCell") as! MyTicketsTableViewCell
        
        cell.requestDateLbl.text = LogicUtils.validateStringByString(word: item.requestDate)
        cell.ticketLbl.text = LogicUtils.validateStringByString(word: item.id.description)
        cell.statusLbl.text = item.status == 0 ? "Pendiente" : "Cancelado"
        
        DesignUtils.containerRound(content: cell.containerViews)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.onOpenMyTicket(myTicket: self.items[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func update(_ items: [MyTicketResponse]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
}

