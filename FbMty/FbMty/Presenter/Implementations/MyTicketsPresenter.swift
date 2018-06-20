//
//  MyTicketsPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class MyTicketsPresenter: BasePresenter {
    
    var delegate: MyTicketsDelegate?
    var request: Alamofire.Request?
    
    init(delegate: MyTicketsDelegate) {
        self.delegate = delegate
    }

    func myTickets(idHolding:Int){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_myTickets, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorMyTickets(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[MyTicketResponse]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onSuccessMyTickets(ticketResponses:  response.result.value!)
                            }else{
                                self.delegate?.onErrorMyTickets(msg:  response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorMyTickets(msg:  error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorMyTickets(msg:  error.localizedDescription)
            }
        }
    }
    
    
    func cancelMyTicket(idHolding: Int,id: Int){
    
        let authorization = "bearer "+RealmManager.token()
        let params: Parameters = ["holdingId" : idHolding, "Id" : id]
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorCancel(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_cancelTicket, method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                            
                        case .success:
                            if statusCode == 200{
                                self.delegate?.onSuccessCancel(msg: "Se ha cancelado correctamente el ticket")
                            }else{
                                self.delegate?.onErrorCancel(msg: response.description)
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onErrorCancel(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                delegate?.onErrorCancel(msg: error.localizedDescription)
            }
        }
    }
    
    func deleteMyTicket(idHolding: Int, id: Int){
        
        let authorization = "bearer "+RealmManager.token()
        let params: Parameters = ["holdingId" : idHolding, "Id" : id]
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorDelete(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_deleteTicket, method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                            
                        case .success:
                            if statusCode == 200{
                                self.delegate?.onSuccessDelete(msg: "Se ha eliminado correctamente el ticket")
                            }else{
                                self.delegate?.onErrorDelete(msg: response.description)
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onErrorDelete(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                delegate?.onErrorDelete(msg: error.localizedDescription)
            }
        }
        
    }
    

    
}
