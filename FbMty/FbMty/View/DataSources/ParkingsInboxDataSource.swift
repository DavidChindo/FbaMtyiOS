//
//  ParkingsInboxDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/20/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class ParkingsInboxDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items:[ServicesDataResponse] = []
    
    var emptyMessage = "No hay datos"
    
    
    init(tableView: UITableView,items:[ServicesDataResponse]) {
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
        
        let cell:ParkingsInboxInboxTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ParkingsInboxInboxCell") as! ParkingsInboxInboxTableViewCell
        let item = self.items[indexPath.row]
        
        DesignUtils.containerRound(content: cell.containerView)

        cell.noTicketLbl.text = item.id.description
        cell.dateRequestLbl.text = LogicUtils.formatterDateMiliseconds(stringDate: item.requestDate!)
        cell.actionLbl.text = action(idAction: item.option)
        cell.statusLbl.text = status(idStatus: item.status)
        cell.numRentsLbl.text = String(item.courtesiesNum)
        
        setMtto(cell: cell, mttoNum: item.maintenanceNum)

        return cell
    }
    
    
    func update(_ items: [ServicesDataResponse]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
    func status(idStatus: Int) -> String {
        switch idStatus {
        case 0:
            return "Pendiente"
        case 1:
            return "En Atención"
        case 2:
            return "Autorizado"
        case 3:
            return "Cancelado"
        default:
            return ""
        }
    }
    
    func action(idAction: Int) -> String{
        return idAction == 0 ? "Agregar" : "Eliminar"
    }
    
    func setMtto(cell: ParkingsInboxInboxTableViewCell, mttoNum: Int){
        
        if mttoNum > 0 {
            cell.numMttoLbl.isHidden = false
            cell.numMttoDescLbl.isHidden = false
            cell.numMttoDescLbl.text = String(mttoNum)
        }else{
            cell.numMttoLbl.isHidden = true
            cell.numMttoDescLbl.isHidden = true
        }
        
    }
    
   
}
