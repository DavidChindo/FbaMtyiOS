//
//  ServicesViewController.swift
//  FbMty
//
//  Created by David Barrera on 1/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import RealmSwift

class ServicesViewController: BaseViewController, ServicesTabDelegate {

    @IBOutlet weak var ServicesTable: UITableView!
    
    var services = List<Service>()
    
    var servicesDataSource:ServicesDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        ServicesTable.dataSource = servicesDataSource
        ServicesTable.delegate = servicesDataSource
        
    }
    
    func initViews(){
        
        if (MenuViewController.holdingResponse?.ServicesAdmin.count)! > 0 {
            services = (MenuViewController.holdingResponse?.ServicesAdmin)!
        }
        
        servicesDataSource = ServicesDataSource(tableView: ServicesTable, items: services, delegate: self)
    }

    func onOpenService(service: Service) {
        
        let idServiceValue = idService(title: service.title!)
        
    }
    
    func idService(title: String)->Int {
        if title.lowercased().contains("cajones") {
            return Constants.SERVICE_PARKINGS
        }else if title.lowercased().contains("tarjetas") {
            return Constants.SERVICE_CARDS
        }else if title.lowercased().contains("cortesias") {
            return Constants.SERVICE_COURTESIES
        }else{
            return 3
        }
    }
    
    
}
