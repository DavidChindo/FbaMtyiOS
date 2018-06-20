//
//  ParkingsRequestViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/19/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner




class ParkingsRequestViewController: BaseViewController, ParkingsRequestDelegate {
    @IBOutlet weak var cancelShortBtn: UIButton!
    
    @IBOutlet weak var title_pricexcardLbl: UILabel!
    @IBOutlet weak var fr_parkings_edt_price_cardLbl: UILabel!
    @IBOutlet weak var fr_parkings_edt_cards_rentTxt: UITextField!
    @IBOutlet weak var titleCardsxrentLbl: UILabel!
    @IBOutlet weak var cardTypeLbl: UILabel!
    @IBOutlet weak var cardSelected: UISegmentedControl!
    @IBOutlet weak var shortContainer: UIView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var priceMttoLbl: UILabel!
    @IBOutlet weak var parkingsMttotxt: UITextField!
    @IBOutlet weak var priceRentLbl: UILabel!
   
    @IBOutlet weak var parkingsRent: UITextField!
    @IBOutlet weak var placeSegmented: UISegmentedControl!
    @IBOutlet weak var boxSegemented: UISegmentedControl!
    @IBOutlet weak var actionSegmented: UISegmentedControl!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerForm: UIView!
    
    @IBOutlet weak var servicesAdminTableView: UITableView!
    
    var serviceRequestAdmin: Service?
    var parkingsRequestPresenter: ParkingsRequestPresenter?
    var servicesDescDataSource: ServiceDescDataSource?
    var mServicesDescResponse: ServicesDescResponse?;
    
    var idService: Int = -1
    var rentValue: Int = 0
    var mttoValue: Int = 0
    var actionType: Int = 0
    
    let TITLEPARKINGS = "Solicitud de Cajones de Estacionamiento"
    let TITLECARDS = "Solicitud de Tarjetas de Estacionamiento"
    let TITLECOURTESIES = "Solicitud de Cortesias"
    let EDTCARDTITLE = "Tarjetas Requeridos Renta"
    let EDTCOURTESIESTITLE = "Cortesias Requeridos Renta"
   
    var servicesDesc:[ServicesDescResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    func initViews(){
        parkingsRequestPresenter = ParkingsRequestPresenter(delegate: self)
        setupPresenter(parkingsRequestPresenter!)
        
        DesignUtils.setBorder(button: cancelBtn, mred: 16, mgreen: 40, mblue: 58)
        DesignUtils.setBorder(button: cancelShortBtn, mred: 16, mgreen: 40, mblue: 58)
        
        servicesDescDataSource = ServiceDescDataSource(tableView: servicesAdminTableView, items: servicesDesc)
        servicesAdminTableView.dataSource = servicesDescDataSource
        servicesAdminTableView.delegate = servicesDescDataSource
        
        SwiftSpinner.show("Cargando...")
        requestServices(idTempService: idService)
        
        titleLbl.text = titleInstructions(idTempService: idService)
        
        parkingsMttotxt.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        parkingsRent.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        fr_parkings_edt_cards_rentTxt.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
    }
    
   
    @IBAction func onBoxSelected(_ sender: UISegmentedControl) {
        
        rentValue = sender.selectedSegmentIndex == 0 ? 0 : 1
        mttoValue = placeSegmented.selectedSegmentIndex == 0 ? 0 : 1
        
        mServicesDescResponse = servicesDescResponseById(box: rentValue, place: mttoValue)
        
        if !(parkingsMttotxt.text?.isEmpty)! {
            let priceMtto = Int(parkingsMttotxt.text!)! * (mServicesDescResponse?.amountPrice)!
            priceMttoLbl.text = String(priceMtto)
        }else{
            priceMttoLbl.text = "0"
        }
        
        if !(parkingsRent.text?.isEmpty)! {
            let priceRent = Int(parkingsRent.text!)! * (mServicesDescResponse?.rentPrice)!
            priceRentLbl.text = String(priceRent)
        }else{
            priceRentLbl.text = "0"
        }

    }
    
    @IBAction func onActionSelectedTap(_ sender: UISegmentedControl) {
        actionType = sender.selectedSegmentIndex == 0 ? 0 : 1
    }
    
    @IBAction func onPlaceSelected(_ sender: UISegmentedControl) {
        mttoValue = sender.selectedSegmentIndex == 0 ? 0 : 1
        rentValue = boxSegemented.selectedSegmentIndex == 0 ? 0 : 1
        
        mServicesDescResponse = servicesDescResponseById(box: rentValue, place: mttoValue)
        
        if !(parkingsMttotxt.text?.isEmpty)! {
            let priceMtto = Int(parkingsMttotxt.text!)! * (mServicesDescResponse?.amountPrice)!
            priceMttoLbl.text = String(priceMtto)
        }else{
            priceMttoLbl.text = "0"
        }
        
        if !(parkingsRent.text?.isEmpty)! {
            let priceRent = Int(parkingsRent.text!)! * (mServicesDescResponse?.rentPrice)!
            priceRentLbl.text = String(priceRent)
        }else{
            priceRentLbl.text = "0"
        }
        
    }
    
    @IBAction func onCardSegmented(_ sender: UISegmentedControl) {
        
        mServicesDescResponse = servicesDescResponseCard(type: sender.selectedSegmentIndex == 0 ? 0 : 1)
        
        if !(fr_parkings_edt_cards_rentTxt.text?.isEmpty)! {
            let priceCard = Int(fr_parkings_edt_cards_rentTxt.text!)! * (mServicesDescResponse?.rentPrice)!
            fr_parkings_edt_price_cardLbl.text = String(priceCard)
        }else{
            fr_parkings_edt_price_cardLbl.text = "0"
        }
    
    }
    
    @IBAction func onCancelCardCourtesiesClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onRequestCardCourtesiesClick(_ sender: Any) {
     
        if !LogicUtils.validateStringByString(word: fr_parkings_edt_cards_rentTxt.text).isEmpty{
            
            let alertEmpty = UIAlertController(title: "Solicitud", message: "¿Seguro de mandar la solicitud?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertEmpty.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action:UIAlertAction!) in
                SwiftSpinner.show("Enviando...")
                self.sentRequestService(idTempoService: self.idService)
            }))
            
            alertEmpty.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: {(action:UIAlertAction!) in
                alertEmpty.dismiss(animated: true, completion: nil)
            }))
            present(alertEmpty, animated: true, completion: nil)
        }else{
            DesignUtils.messageError(vc: self, title: "Validación", msg: "Campos Requeridos")
        }

    }
    
    @IBAction func onCancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onRequestClick(_ sender: Any) {
        
        if !LogicUtils.validateStringByString(word: parkingsRent.text).isEmpty && !LogicUtils.validateStringByString(word: parkingsMttotxt.text).isEmpty{
            
            let alertEmpty = UIAlertController(title: "Solicitud", message: "¿Seguro de mandar la solicitud?", preferredStyle: UIAlertControllerStyle.alert)
            
            alertEmpty.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action:UIAlertAction!) in
                SwiftSpinner.show("Enviando...")
                self.sentRequestService(idTempoService: self.idService)
            }))
            
            alertEmpty.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: {(action:UIAlertAction!) in
                alertEmpty.dismiss(animated: true, completion: nil)
            }))
            present(alertEmpty, animated: true, completion: nil)
        }else{
            DesignUtils.messageError(vc: self, title: "Validación", msg: "Campos Requeridos")
        }
        
    }
    
    func onSuccessSubmitTicketService(msg: String?) {
        SwiftSpinner.hide()
        clearFields()
        DesignUtils.messageSuccess(vc: self, title: "", msg: msg!)
    }
    
    func onLoadServicesParkings(servicesDescResponses: [ServicesDescResponse]) {
        
        servicesDesc = servicesDescResponses
        servicesDescDataSource?.update(servicesDescResponses)
        
        if idService == Constants.SERVICE_PARKINGS {
            mServicesDescResponse = servicesDescResponseById(box: rentValue, place: mttoValue)
        }else if idService == Constants.SERVICE_CARDS{
            mServicesDescResponse = servicesDescResponseCard(type: 0)
        }else{
            mServicesDescResponse = servicesDescResponses[0]
        }
        
        SwiftSpinner.hide()
    }
    
    func onReloadServicesList() {
        
    }
    
    func onErrorSubmitTicketService(msg: String?) {
        SwiftSpinner.hide()
        clearFields()
        DesignUtils.messageError(vc: self, title: "", msg: msg!)
    }
    
    func onErrorServicesParkings(msgError: String?) {
        SwiftSpinner.hide()
        DesignUtils.messageError(vc: self, title: "", msg: msgError!)
    }
    
    func titleInstructions(idTempService: Int) -> String{
        switch (idTempService){
        
        case Constants.SERVICE_PARKINGS:
            shortContainer.isHidden = true
            containerForm.isHidden = false
            
            scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 870)
            containerView.frame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y, width: containerView.frame.width, height: 870)
            
            return TITLEPARKINGS;
        
        case Constants.SERVICE_CARDS:
            containerForm.isHidden = true
            shortContainer.isHidden = false
            cardTypeLbl.isHidden = false
            cardSelected.isHidden = false
            titleCardsxrentLbl.text = EDTCARDTITLE
            scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 650)
            shortContainer.frame = CGRect(x: shortContainer.frame.origin.x, y: shortContainer.frame.origin.y, width: shortContainer.frame.width, height: 270)
            return TITLECARDS;
        
        case  Constants.SERVICE_COURTESIES:
            shortContainer.isHidden = false
            containerForm.isHidden = true
            cardTypeLbl.isHidden = true
            cardSelected.isHidden = true
            titleCardsxrentLbl.text = EDTCOURTESIESTITLE
            scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 650)
            shortContainer.frame = CGRect(x: shortContainer.frame.origin.x, y: shortContainer.frame.origin.y, width: shortContainer.frame.width, height: 270)
            return TITLECOURTESIES;
      
        default:
            return "";
        }
    }
    
    func requestServices(idTempService: Int){
        switch idTempService {
        case Constants.SERVICE_PARKINGS:
            parkingsRequestPresenter?.cajonesEstByUserAndHolding(idHolding: (MenuViewController.holdingResponse?.Id)!)
        case Constants.SERVICE_CARDS:
            parkingsRequestPresenter?.tarjetasEstByUserAndHolding(idHolding: (MenuViewController.holdingResponse?.Id)!)
        case Constants.SERVICE_COURTESIES:
            parkingsRequestPresenter?.CortesiasEstByUserAndHolding(idHolding:  (MenuViewController.holdingResponse?.Id)!)
        default: break
        }
        
    }
    
    func servicesDescResponseById(box: Int, place: Int) -> ServicesDescResponse{
        
        var servicesDescResponse:ServicesDescResponse?;
        
        if (box == 0 && place == 0){
            for serviceDesc in servicesDesc {
                if serviceDesc.id == 10 {
                    servicesDescResponse = serviceDesc
                }
            }
        }else if (box == 0 && place == 1){
            for serviceDesc in servicesDesc {
                if serviceDesc.id == 11 {
                    servicesDescResponse = serviceDesc
                }
            }
        }else if (box == 1 && place == 0){
            for serviceDesc in servicesDesc {
                if serviceDesc.id == 12 {
                    servicesDescResponse = serviceDesc
                }
            }
        }else if (box == 1 && place == 1){
            for serviceDesc in servicesDesc {
                if serviceDesc.id == 13 {
                    servicesDescResponse = serviceDesc
                }
            }
        }
        
        return  servicesDescResponse!;

    }
    
    func servicesDescResponseCard(type: Int) -> ServicesDescResponse{
        
        var servicesDescResponse: ServicesDescResponse?
        
        if type == 0{
            for service in servicesDesc {
                if service.id == 14 {
                    servicesDescResponse = service
                }
            }
        }else{
            for service in servicesDesc {
                if service.id == 15 {
                    servicesDescResponse = service
                }
            }
        }
    
        return servicesDescResponse!
    }
    
    
    func sentRequestService(idTempoService: Int){
        
        switch idTempoService {
        case Constants.SERVICE_PARKINGS:
            let numCortesisas = Int(parkingsRent.text!)
            let numMtto = Int(priceMttoLbl.text!)
            let precioCortesia = Int(priceRentLbl.text!)
            let precioMtto = Int(priceMttoLbl.text!)
            
            parkingsRequestPresenter?.sentCajonesEst(idHolding: (mServicesDescResponse?.HoldingId)!, id: (mServicesDescResponse?.id)!, numCortesias: numCortesisas!, numMntos: numMtto!, precioCortesia: precioCortesia!, precioMnto: precioMtto!, tipoAccion: actionType)
         
            break
            
        case Constants.SERVICE_CARDS:
            let numCortesiasCards = Int(fr_parkings_edt_cards_rentTxt.text!)
            let precioCortesiasCards = Int(fr_parkings_edt_price_cardLbl.text!)
            
            parkingsRequestPresenter?.sendTarjetasEstTickets(idHolding: (mServicesDescResponse?.HoldingId)!, id: (mServicesDescResponse?.id)!, numCortesias: numCortesiasCards!, precioCortesia: precioCortesiasCards!)
          
            break
            
        case Constants.SERVICE_COURTESIES:
            let numCortesiasCards1 = Int(fr_parkings_edt_cards_rentTxt.text!)
            let precioCortesiasCards1 = Int(fr_parkings_edt_price_cardLbl.text!)
            
            parkingsRequestPresenter?.sendCortesiasEstTickets(idHolding: (mServicesDescResponse?.HoldingId)!, id: (mServicesDescResponse?.id)!, numCortesias: numCortesiasCards1!, precioCortesia: precioCortesiasCards1!)
            
            break
        
        default:
            break
        }
    }

    func textFieldDidChange(textField: UITextField) {
        
        if textField == parkingsMttotxt{
            if !(parkingsMttotxt.text?.isEmpty)! {
                let priceMtto = Int(parkingsMttotxt.text!)! * (mServicesDescResponse?.amountPrice)!
                priceMttoLbl.text = String(priceMtto)
            }else{
                priceMttoLbl.text = "0"
            }
        }

        if textField == parkingsRent{
            if !(parkingsRent.text?.isEmpty)! {
                let priceRent = Int(parkingsRent.text!)! * (mServicesDescResponse?.rentPrice)!
                priceRentLbl.text = String(priceRent)
            }else{
                priceRentLbl.text = "0"
            }
        }
        
        if textField == fr_parkings_edt_cards_rentTxt{
            if !(fr_parkings_edt_cards_rentTxt.text?.isEmpty)! {
                let priceCard = Int(fr_parkings_edt_cards_rentTxt.text!)! * (mServicesDescResponse?.rentPrice)!
                fr_parkings_edt_price_cardLbl.text = String(priceCard)
            }else{
                fr_parkings_edt_price_cardLbl.text = "0"
            }
        }
    }
 
 
    func clearFields(){
        priceMttoLbl.text = ""
        parkingsMttotxt.text = ""
        priceRentLbl.text = ""
        parkingsRent.text = ""
    }
    
}

