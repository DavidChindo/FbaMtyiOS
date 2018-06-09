//
//  ActivityDataSource.swift
//  FbMty
//
//  Created by David Barrera on 1/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class ActivityDataSource: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    var tableView: UITableView?
    var items: [String] = []
    
    init(tableView: UITableView,items:[String]) {
        self.tableView = tableView
        self.items = items
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ActivityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "activityCell") as! ActivityTableViewCell
        let item = self.items[indexPath.row]
        DesignUtils.containerRound(content: cell.containerView)
        return cell
    }
    
    func update(_ items: [String]){
        self.items.removeAll()
        self.items.append(contentsOf: items)
        self.tableView?.reloadData()
    }
    
}

