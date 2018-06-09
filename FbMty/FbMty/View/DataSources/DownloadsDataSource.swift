//
//  DownloadsDataSource.swift
//  FbMty
//
//  Created by David Barrera on 6/8/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class DownloadsDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items: [String] = []
    
    var delegate: DownloadDelegate?
    
    init(tableView: UITableView,items:[String], delegate: DownloadDelegate) {
        self.tableView = tableView
        self.items = items
        self.delegate = delegate
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if items.count > 0 {
            return self.items.count
        }else{
            return 0
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DownloadsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "downloadCell") as! DownloadsTableViewCell
        
        let item = self.items[indexPath.row]
        
        cell.lblTitle.text = LogicUtils.validateStringByString(word: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onOpenDocto(path: self.items[indexPath.row])
    }
    
    func update(_ items: [String]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
}

