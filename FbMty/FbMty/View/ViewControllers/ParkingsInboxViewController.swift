//
//  ParkingsInboxViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/19/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner

class ParkingsInboxViewController: BaseViewController, ParkingsInboxDelegate,UIPickerViewDelegate  {

    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var containerFilter: UIView!
    var serviceInboxAdmin: Service?
    
    var parkingsInbox: ParkingsInboxPresenter?
    var parkingsInboxDataSource: ParkingsInboxDataSource?
    
    var idService: Int = -1
    
    var servicesDataResponse: [ServicesDataResponse] = []
    
    
    var datesFiltes:[StatusParkings] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        initViews()                            
    }
    
    func initViews(){
        parkingsInbox = ParkingsInboxPresenter(delegate: self)
        setupPresenter(parkingsInbox!)
        DesignUtils.containerRound(content: containerFilter)
        parkingsInboxDataSource = ParkingsInboxDataSource(tableView: resultsTableView, items: servicesDataResponse)
        
        resultsTableView.dataSource = parkingsInboxDataSource
        resultsTableView.delegate = parkingsInboxDataSource
        
        datesFiltes = statusParkings()
        
        statusPicker.delegate = self
        
        SwiftSpinner.show("Cargando...")
        requestServices(idTempService: idService)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datesFiltes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datesFiltes[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var mServicesDataResponsesFilters: [ServicesDataResponse] = []
        let statusParking =  datesFiltes[row]
        if LogicUtils.isObjectNotNil(object: statusParking) {
            if statusParking.value >= 0 {
                for sp in servicesDataResponse {
                    if sp.status == statusParking.value {
                        mServicesDataResponsesFilters.append(sp)
                    }
                }
                parkingsInboxDataSource?.update(mServicesDataResponsesFilters)
            }else{
                parkingsInboxDataSource?.update(servicesDataResponse)
            }
        }

    }
    
    func onErrorServicesData(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.messageError(vc: self, title: "", msg: msg!)
    }
    
    func onLoadServicesData(servicesDataResponses: [ServicesDataResponse]) {
        SwiftSpinner.hide()
        self.servicesDataResponse = servicesDataResponses
        parkingsInboxDataSource?.update(servicesDataResponses)
        
    }
    
    func requestServices(idTempService: Int){
        switch idTempService {
        case Constants.SERVICE_PARKINGS:
            parkingsInbox?.getHoldingUserParkingLotsTickets(idHolding: (MenuViewController.holdingResponse?.Id)!)
        case Constants.SERVICE_CARDS:
            parkingsInbox?.getHoldingUserParkingCardsTickets(idHolding: (MenuViewController.holdingResponse?.Id)!)
        case Constants.SERVICE_COURTESIES:
            parkingsInbox?.getHoldingUserParkingMembershipsTickets(idHolding: (MenuViewController.holdingResponse?.Id)!)
        default:
            break
        }
    }
    
    func statusParkings()->[StatusParkings] {
        var status:[StatusParkings] = []
        status.append(StatusParkings(title: "Todos", value: -1))
        status.append(StatusParkings(title: "Pendiente", value: 0))
        status.append(StatusParkings(title: "En Atención", value: 1))
        status.append(StatusParkings(title: "Autorizado", value: 2))
        status.append(StatusParkings(title: "Cancelado", value: 3))
        
        return status
    }
}
