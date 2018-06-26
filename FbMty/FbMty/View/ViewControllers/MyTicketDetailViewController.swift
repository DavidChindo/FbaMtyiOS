//
//  MyTicketDetailViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/18/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
import STPopup

class MyTicketDetailViewController: BaseViewController,MyTicketsDelegate {
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var containerMajor: UIView!
    @IBOutlet weak var noTicketLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var observationstxtView: UITextView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var requestDateLbl: UILabel!

    var myTicketPresenter: MyTicketsPresenter?
    var myTicket:MyTicketResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = DesignUtils.primaryDark
        
        self.contentSizeInPopup = CGSize(width: 310, height: 420)
        self.landscapeContentSizeInPopup = CGSize(width: 300, height: 150)
        
        initViews()
    }
    
    func initViews(){
        myTicketPresenter = MyTicketsPresenter(delegate: self)
        setupPresenter(myTicketPresenter!)
        
        if LogicUtils.isObjectNotNil(object: myTicket){
            noTicketLbl.text = myTicket?.id.description
            statusLbl.text = myTicket?.status == 0 ? "Pendiente" : "Cancelado"
            cancelBtn.isHidden = myTicket?.status == 0 ? false : true
            observationstxtView.text = myTicket?.observationsAdmin
            requestDateLbl.text = LogicUtils.formatterDateMiliseconds(stringDate: (myTicket?.requestDate)!)
            observationstxtView.sizeToFit()
            var frame = observationstxtView.frame
            frame.size.height = observationstxtView.contentSize.height
            observationstxtView.frame = frame

            deleteBtn.frame = CGRect(x: deleteBtn.frame.origin.x, y: (observationstxtView.frame.origin.y + observationstxtView.frame.height + 4), width: deleteBtn.frame.width, height: deleteBtn.frame.height)
            
            cancelBtn.frame = CGRect(x: cancelBtn.frame.origin.x, y: deleteBtn.frame.origin.y, width: cancelBtn.frame.width, height: cancelBtn.frame.height)
            
            containerMajor.frame = CGRect(x: containerMajor.frame.origin.x, y: containerMajor.frame.origin.y, width: containerMajor.frame.width, height: (deleteBtn.frame.origin.y + deleteBtn.frame.height + 20))
            
        }
    }
    
    @IBAction func onDeleteTicketClick(_ sender: Any) {
        SwiftSpinner.show("Enviando...")
        myTicketPresenter?.deleteMyTicket(idHolding: (MenuViewController.holdingResponse?.Id)!, id: (myTicket?.id)!)
    }
    
    @IBAction func onCancelTicketClick(_ sender: Any) {
        SwiftSpinner.show("Enviando...")
        myTicketPresenter?.cancelMyTicket(idHolding: (MenuViewController.holdingResponse?.Id)!, id: (myTicket?.id)!)
    }
    
    @IBAction func onViewFileClick(_ sender: Any) {
        
        if LogicUtils.validateString(word: myTicket?.filePath) && !(myTicket?.filePath?.isEmpty)! {
            let path = myTicket?.filePath
            loadUrlInWebView(urlTemp: path!)
        }else {
            DesignUtils.alertConfirm(titleMessage: "Mis Tickets", message: "Por el momento no se puede visualizar el documento.", vc: self)
        }
        
    }
    

    func onSuccessDelete(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirmFinish(titleMessage: "Mis Tickets", message: msg!, vc: self)
    }
    
    func onSuccessCancel(msg: String?) {
        SwiftSpinner.hide()
         DesignUtils.alertConfirmFinish(titleMessage: "Mis Tickets", message: msg!, vc: self)
    }
    
    func onErrorDelete(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirm(titleMessage: "Mis Tickets", message: msg!, vc: self)
    }
    
    func onErrorCancel(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirm(titleMessage: "Mis Tickets", message: msg!, vc: self)
    }
    
    func onErrorMyTickets(msg: String?) {
        
    }
    
    func onSuccessMyTickets(ticketResponses: [MyTicketResponse]) {
        
    }
    
    func onOpenMyTicket(myTicket: MyTicketResponse?) {
        
    }
    
    func loadUrlInWebView(urlTemp:String){
        let url = URL(string: urlTemp)
        
        if url != nil{
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
        }else{
            DesignUtils.alertConfirm(titleMessage: "Mis Tickets", message: "Por el momento no se puede visualizar el documento.", vc: self)
        }
    }

}
