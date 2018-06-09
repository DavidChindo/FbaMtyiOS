//
//  TicketPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/31/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class TicketPresenter: BasePresenter {

    var delegate: TicketDelegate?
    var request: Alamofire.Request?
 
    init(delegate: TicketDelegate) {
        self.delegate = delegate
    }
    
    func uploadTicket(urlZip: URL, descriptionS: String, serviceId: String, holdingId: String){
        
        let authorization = "bearer " + RealmManager.token()
        
        let status = Reach().connectionStatus()
        
        switch status {
        case .unknown, .offline:
            self.delegate?.onSentTicketError(msg: "No hay conexión a Internet")
        case .online(.wwan), .online(.wiFi):
            upload(multipartFormData: { multipartFormData in
                multipartFormData.append(urlZip, withName: "file")
                multipartFormData.append(serviceId.data(using: String.Encoding.utf8)!, withName: "serviceId")
                multipartFormData.append(holdingId.data(using: String.Encoding.utf8)!, withName: "holdingId")
                multipartFormData.append(descriptionS.data(using: String.Encoding.utf8)!, withName: "descripcion")
            }, usingThreshold:.allZeros, to: Urls.API_sendTicket, method: .post, headers: ["Authorization" : authorization], encodingCompletion: {encondingResult in
                switch encondingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress { progess in
                        print("Progreso:  \(progess.fractionCompleted)")
                    }
                    
                    upload.responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        switch response.result{
                        case .success:
                            if response.response?.statusCode == Constants.STATUS_OK{
                                let idTicket = response.result.value! as! Double
                                self.delegate?.onSentTicketSuccess(msg: "Se ha enviado correctamente el ticket número :  + \(idTicket)")
                            }else{
                                self.delegate?.onSentTicketError(msg: response.description)
                            }
                        case .failure(let error):
                                if error.localizedDescription.contains("offline") || error.localizedDescription.contains("timed out"){
                                    self.delegate?.onSentTicketError(msg: "No se podido enviar el ticket, verificar conexión a internet.")
                                }else{
                                    self.delegate?.onSentTicketError(msg: "Ha sucedido un error.")
                                }
                        }
                    })
                case .failure(let error):
                    print("error")
                    if error.localizedDescription.contains("offline") || error.localizedDescription.contains("timed out"){
                        self.delegate?.onSentTicketError(msg: "No se podido enviar el ticket, verificar conexión a internet.")
                    }else{
                        self.delegate?.onSentTicketError(msg: "Ha sucedido un error.")
                    }
                }
            })
        }
        
    }
}


