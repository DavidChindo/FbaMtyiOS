//
//  MyTicketsViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/18/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
import STPopup

class MyTicketsViewController: BaseViewController,MyTicketsDelegate {
    
    @IBOutlet weak var myTicketTableView: UITableView!

    var myTicketsPresenter: MyTicketsPresenter?
    var myTicketDataSource: MyTicketsDataSource?
    var myTickets:[MyTicketResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mis Tickets"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
        
       
        initViews()
    }
    
    func initViews(){
        
        myTicketsPresenter = MyTicketsPresenter(delegate: self)
        setupPresenter(myTicketsPresenter!)
        
        myTicketDataSource = MyTicketsDataSource(tableView: myTicketTableView, items: myTickets, delegate: self)
        
        myTicketTableView.dataSource = myTicketDataSource
        myTicketTableView.delegate = myTicketDataSource
        
        SwiftSpinner.show("Cargando...")
        myTicketsPresenter?.myTickets(idHolding: (MenuViewController.holdingResponse?.Id)!)
    }

    func onSuccessMyTickets(ticketResponses: [MyTicketResponse]) {
        
        myTickets = ticketResponses
        
        myTicketDataSource?.update(ticketResponses)
        
        SwiftSpinner.hide()
    }

    func onErrorMyTickets(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.messageError(vc: self, title: "Mis Tickets", msg: msg!)
        
    }
    
    func onErrorCancel(msg: String?) {
        
    }
    
    func onErrorDelete(msg: String?) {
        
    }
    
    func onSuccessCancel(msg: String?) {
        
    }
    
    func onSuccessDelete(msg: String?) {
        
    }
    
    func onOpenMyTicket(myTicket: MyTicketResponse?) {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "MyTicketDetailId") as! MyTicketDetailViewController
        viewController.myTicket = myTicket
        viewController.title  = LogicUtils.validateStringByString(word: myTicket?.descriptionMsg)
        
        let popup : STPopupController = STPopupController(rootViewController: viewController)
        popup.containerView.layer.cornerRadius = 4
        popup.style = STPopupStyle.formSheet
        popup.navigationBar.barTintColor = DesignUtils.colorPrimary
        popup.navigationBar.backgroundColor = DesignUtils.colorPrimary
        popup.navigationBar.tintColor = UIColor.white
        
        popup.present(in: self)
    }
    
    func dissmissView(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}
