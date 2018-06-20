//
//  ParkingsRequestPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class ParkingsRequestPresenter: BasePresenter {

    var delegate: ParkingsRequestDelegate?
    var request: Alamofire.Request?
    
    init(delegate: ParkingsRequestDelegate) {
        self.delegate = delegate
    }
 
    func cajonesEstByUserAndHolding(idHolding:Int){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_cajonesEstByUserAndHolding, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorServicesParkings(msgError: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[ServicesDescResponse]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadServicesParkings(servicesDescResponses: response.result.value!)
                            }else{
                                self.delegate?.onErrorServicesParkings(msgError: response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorServicesParkings(msgError: error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorServicesParkings(msgError: error.localizedDescription)
            }
        }
    }
    
    func tarjetasEstByUserAndHolding(idHolding:Int){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_tarjetasEstByUserAndHolding, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorServicesParkings(msgError: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[ServicesDescResponse]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadServicesParkings(servicesDescResponses: response.result.value!)
                            }else{
                                self.delegate?.onErrorServicesParkings(msgError: response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorServicesParkings(msgError: error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorServicesParkings(msgError: error.localizedDescription)
            }
        }
    }
    
    func CortesiasEstByUserAndHolding(idHolding:Int){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_CortesiasEstByUserAndHolding, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorServicesParkings(msgError: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[ServicesDescResponse]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadServicesParkings(servicesDescResponses: response.result.value!)
                            }else{
                                self.delegate?.onErrorServicesParkings(msgError: response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorServicesParkings(msgError: error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorServicesParkings(msgError: error.localizedDescription)
            }
        }
    }

    func sentCajonesEst(idHolding: Double, id: Double,numCortesias: Int ,numMntos: Int, precioCortesia: Int,precioMnto: Int, tipoAccion: Int){
        
        let authorization = "bearer "+RealmManager.token()
        let params: Parameters = ["parkingHoldingId" : idHolding, "holdingId" : id, "numCortesias" : numCortesias, "numMntos" : numMntos, "precioCortesia" : precioCortesia, "precioMnto" : precioMnto, "tipoAccion" : tipoAccion]
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorSubmitTicketService(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_sendCajonesEstTickets, method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                            
                        case .success:
                            if statusCode == 200{
                                let ticket = response.result.value! as! Double
                                self.delegate?.onSuccessSubmitTicketService(msg: "Su Ticket " + String(ticket) + " se ha enviado, se notificará por correo el estatus o bien desde su bandeja de ticket")
                            }else{
                                self.delegate?.onErrorSubmitTicketService(msg: response.description)
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onErrorSubmitTicketService(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                delegate?.onErrorSubmitTicketService(msg: error.localizedDescription)
            }
        }
        
    }
    
    
    func sendTarjetasEstTickets(idHolding: Double, id: Double,numCortesias: Int , precioCortesia: Int){
        
        let authorization = "bearer "+RealmManager.token()
        let params: Parameters = ["parkingHoldingId" : idHolding, "holdingId" : id, "numCortesias" : numCortesias, "precioCortesia" : precioCortesia,]
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorSubmitTicketService(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_sendTarjetasEstTickets, method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                            
                        case .success:
                            if statusCode == 200{
                                let ticket = response.result.value! as! Double
                                self.delegate?.onSuccessSubmitTicketService(msg: "Su Ticket " + String(ticket) + " se ha enviado, se notificará por correo el estatus o bien desde su bandeja de ticket")
                            }else{
                                self.delegate?.onErrorSubmitTicketService(msg: response.description)
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onErrorSubmitTicketService(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                delegate?.onErrorSubmitTicketService(msg: error.localizedDescription)
            }
        }
        
    }
    
    func sendCortesiasEstTickets(idHolding: Double, id: Double,numCortesias: Int , precioCortesia: Int){
        
        let authorization = "bearer "+RealmManager.token()
        let params: Parameters = ["parkingHoldingId" : idHolding, "holdingId" : id, "numCortesias" : numCortesias, "precioCortesia" : precioCortesia,]
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorSubmitTicketService(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_sendCortesiasEstTickets, method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                            
                        case .success:
                            if statusCode == 200{
                                let ticket = response.result.value! as! Double
                                self.delegate?.onSuccessSubmitTicketService(msg: "Su Ticket " + String(ticket) + " se ha enviado, se notificará por correo el estatus o bien desde su bandeja de ticket")
                            }else{
                                self.delegate?.onErrorSubmitTicketService(msg: response.description)
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onErrorSubmitTicketService(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                delegate?.onErrorSubmitTicketService(msg: error.localizedDescription)
            }
        }
        
    }
    
    
}
