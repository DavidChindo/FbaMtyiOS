//
//  TicketsDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/15/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift
import Kingfisher

class TicketsDataSource:  NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items = List<Service>()
    
    var emptyMessage = "No hay tickets"
    var delegate: TicketsDelegate?
    
    init(tableView: UITableView,items:List<Service>, delegate: TicketsDelegate) {
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
        let cell:TicketsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TicketsCell") as! TicketsTableViewCell
        let item = self.items[indexPath.row]
        DesignUtils.setBorderView(view: cell.containerMajor,mred: 209, mgreen: 211, mblue: 212)
        cell.titleLbl.text = item.descriptionSer
        
        let url = URL(string: Urls.API_FBMTY + (item.icon)! + ".png")
        print(indexPath.row.description)
        print(url?.absoluteString)
        reloadImage(url: url!, image: cell.imgIcon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onOpenTicket(ticket: self.items[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func update(_ items: [Service]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
    func reloadImage(url: URL,image: UIImageView?){
        
        let resource = ImageResource(downloadURL: url)
        
        let imagePlaceHolder = UIImage(named: "icPlaceHolder")
        if let imgView = image{
            imgView.kf.indicatorType = .activity
            imgView.kf.base.clipsToBounds = true
            imgView.kf.setImage(with: resource)
            imgView.kf.setImage(with: resource, placeholder: imagePlaceHolder, options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: nil)
        }
    }
    
}

