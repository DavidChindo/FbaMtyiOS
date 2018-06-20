//
//  ServiceDescDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/19/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class ServiceDescDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items:[ServicesDescResponse] = []
    
    var emptyMessage = "No hay datos"
    
    
    init(tableView: UITableView,items:[ServicesDescResponse]) {
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
        
        let cell:ServiceDescTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ServiceDescId") as! ServiceDescTableViewCell
        let item = self.items[indexPath.row]
        
        DesignUtils.containerRound(content: cell.containerView)
        cell.titleLbl.text = titleCard(descriptionS: item.descriptionMsg!)
        cell.boxesNumLbl.text = numberFormats(title: cell.titleLbl.text!, counts: item.availables)
        cell.rentLbl.text = String(format: Constants.PRICE, item.rentPrice)
        cell.mttoLbl.text = String(format: Constants.PRICE, item.amountPrice)
        
        hideMtto(title: cell.titleLbl.text!, cell: cell)
        
        return cell
    }
    

    func update(_ items: [ServicesDescResponse]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
    func titleCard(descriptionS: String) -> String{
        var title: String  = ""
    if (!descriptionS.isEmpty){
        if (descriptionS.lowercased().contains("contrato pool")){
            return  "Contrato Pool";
        }else if(descriptionS.lowercased().contains("contrato reservado")){
            return "Contrato Reservado";
        }else if(descriptionS.lowercased().contains("adicionales pool")){
            return "Adicionales Pool";
        }else if(descriptionS.lowercased().contains("adicionales reservado")){
            return "Adicionales Reservado";
        }else if(descriptionS.lowercased().contains("estacionamiento normal")){
            return "Normal";
        }else if(descriptionS.lowercased().contains("tag master")){
            return "Tag Master";
        }else if(descriptionS.lowercased().contains("cortesia")){
            return "Cortesías de Estacionamiento";
        }
    }

        return title;
    }
    
    func numberFormats(title: String, counts: Int) -> String{
        if title.contains("Contrato") || title.contains("Adicionales") {
            return String(format: Constants.NUM_BOXES, counts)
        }else if title.contains("Normal") || title.contains("Tag") {
            return String(format: Constants.NUM_CARDS, counts)
        }else {
            return String(format: Constants.NUM_COURTESIES, counts)
        }
    }
    
    func hideMtto(title: String, cell: ServiceDescTableViewCell){
        
        if title.contains("Normal") || title.contains("Tag") || title.contains("Estacionamiento"){
            cell.mttoLbl.isHidden = true
            cell.titleMttoLbl.isHidden = true
        }else {
            cell.mttoLbl.isHidden = false
            cell.titleMttoLbl.isHidden = false
        }
    }
}


