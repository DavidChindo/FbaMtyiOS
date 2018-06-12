//
//  MaintenanceDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class MaintenanceDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items:[Maintenance] = []
    
    var emptyMessage = "No hay datos"
    var delegate: MaintenanceDelegate?
    
    init(tableView: UITableView,items:[Maintenance], delegate: MaintenanceDelegate) {
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
        
        let cell:MaintenanceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "maintenanceID") as! MaintenanceTableViewCell
        let item = self.items[indexPath.row]
        
        DesignUtils.containerRound(content: cell.containerView)
        cell.titleLbl.text = " " + item.title!
        cell.descriptionLbl.text = item.descriptionMa
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelectedMaintenance(maintenance: self.items[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func update(_ items: [Maintenance]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
}

