//
//  ChatPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Realm

class ChatPresenter: BasePresenter {

    var delegate: ChatDelegate?
    var request: Alamofire.Request?
    
    init(delegate: ChatDelegate) {
        self.delegate = delegate
    }
    
    func messages(idHolding:Int){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_messages, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrrorMessages(msg: "No hay conexión a Internet.")
        
        case .online(.wwan),.online(.wiFi):
        
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[MessageResponse]>) in
            
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadMessages(messages: response.result.value!)
                            }else{
                                self.delegate?.onErrrorMessages(msg: response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrrorMessages(msg: error.localizedDescription)
                        }})
                
        
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrrorMessages(msg: error.localizedDescription)
            }
        }
    }
    
    
    func valid(field:UITextView){
        var isValid:Bool = true
        var msg:String = ""
        if(Validators.validateUITextView(textField: field)){
                isValid = true
        }else{
                msg =  "El campo mensaje es requerido"
                isValid = false
        }
        self.delegate?.onValid(isValid: isValid, msg: msg)
    }
    
    func chatSent(msg:String?, idHolding:Int){
        
        let authorization = "bearer "+RealmManager.token()
        let params: Parameters = ["holdingId" : idHolding, "message" : msg!]
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorSentMessage(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_sentMessage, method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                  
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                        
                        case .success:
                            if statusCode == 200{
                                let isSent = response.result.value! as! Bool
                                self.delegate?.onSuccessSentMessage(isSent: isSent)
                            }else{
                                self.delegate?.onErrorSentMessage(msg: response.description)
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onErrorSentMessage(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                delegate?.onErrorSentMessage(msg: error.localizedDescription)
            }
        }
    }
}


