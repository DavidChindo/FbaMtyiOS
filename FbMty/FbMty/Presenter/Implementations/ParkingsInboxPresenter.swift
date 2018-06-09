//
//  ParkingsInboxPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class ParkingsInboxPresenter: BasePresenter {

    var delegate: ParkingsInboxDelegate?
    var request: Alamofire.Request?
    
    init(delegate: ParkingsInboxDelegate) {
        self.delegate = delegate
    }
    
    func getHoldingUserParkingLotsTickets(idHolding:Double){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_getHoldingUserParkingLotsTickets, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorServicesData(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[ServicesDataResponse]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadServicesData(servicesDataResponses: response.result.value!)
                            }else{
                                self.delegate?.onErrorServicesData(msg:  response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorServicesData(msg: error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorServicesData(msg: error.localizedDescription)
            }
        }
    }

    
    func getHoldingUserParkingMembershipsTickets(idHolding:Double){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_getHoldingUserParkingMembershipsTickets, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorServicesData(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[ServicesDataResponse]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadServicesData(servicesDataResponses: response.result.value!)
                            }else{
                                self.delegate?.onErrorServicesData(msg:  response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorServicesData(msg: error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorServicesData(msg: error.localizedDescription)
            }
        }
    }

    
    func getHoldingUserParkingCardsTickets(idHolding:Double){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_getHoldingUserParkingCardsTickets, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorServicesData(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[ServicesDataResponse]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadServicesData(servicesDataResponses: response.result.value!)
                            }else{
                                self.delegate?.onErrorServicesData(msg:  response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorServicesData(msg: error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorServicesData(msg: error.localizedDescription)
            }
        }
    }

}
