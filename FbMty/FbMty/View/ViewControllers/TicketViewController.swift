//
//  TicketViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class TicketViewController: BaseViewController, TicketsDelegate {

    @IBOutlet weak var ticketTableView: UITableView!
    
    var servicesTicket = List<Service>()
    var ticketDataSource: TicketsDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tickets"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()

        initViews()
        
        ticketTableView.dataSource = ticketDataSource
        ticketTableView.delegate = ticketDataSource
    }

    func initViews(){
        
        if (MenuViewController.holdingResponse?.ServiceTickets.count)! > 0 {
            
            servicesTicket = (MenuViewController.holdingResponse?.ServiceTickets)!
            
            ticketDataSource = TicketsDataSource(tableView: ticketTableView, items: servicesTicket, delegate: self)
        }
    }
    
    func dissmissView(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    func onOpenTicket(ticket: Service) {
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
}
