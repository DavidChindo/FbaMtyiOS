//
//  PaymentsDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class PaymentsDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items:[Payments] = []
    
    var emptyMessage = "No hay datos"
    var delegate: PaymentsDelegate?
    
    init(tableView: UITableView,items:[Payments], delegate: PaymentsDelegate) {
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
        
        let cell:PaymentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "paymentscell") as! PaymentsTableViewCell
        
        let item = self.items[indexPath.row]
        
        cell.dateLbl.text = LogicUtils.validateStringByString(word: item.dateValidity)
        cell.statusLbl.text = LogicUtils.validateStringByString(word: item.status)
        cell.idDocumentLbl.text = LogicUtils.validateStringByString(word: item.documentNumber)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.onOpenPayments(payment: self.items[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func update(_ items: [Payments]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
}

