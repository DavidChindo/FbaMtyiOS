//
//  RegisterPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper


class RegisterPresenter: BasePresenter {
    
    var delegate: RegisterDelegate?
    var request: Alamofire.Request?
    
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
    }
    
    func register(registerRequest: RegisterRequest){
        let params = Mapper().toJSON(registerRequest)
        
        let authorization = "bearer "+RealmManager.token()
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            self.delegate?.onErrorRegister(msg:  "No hay conexión a Internet")
        case .online(.wwan),.online(.wiFi):
            do{
                try
                    request = Alamofire.request(Urls.API_register, method: .post, parameters: params, encoding:JSONEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        switch response.result{
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onSuccessRegister(msg: "Registro exitoso")
                            }else{
                                self.delegate?.onErrorRegister(msg: "Por el momento no es posible registrarse")
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onErrorRegister(msg: error.localizedDescription)
                        }
                    })
            }catch let error{
                print(error.localizedDescription)
                self.delegate?.onErrorRegister(msg: error.localizedDescription)
            }
        }
    }

    func validPassword(pass: UITextField, confirmPassword: UITextField){
        
        if(pass.text == confirmPassword.text){
            self.delegate?.onValidPassword(isEquals: true, msg: "")
        }else{
            self.delegate?.onValidPassword(isEquals: false, msg: "No coinciden las contraseñas")
        }
    }
    
    func valid(fields:[UITextField]){
        
        var isValid: Bool = true
        var msg: String = ""
        
        for  item in fields {
            if(!(item.text?.isEmpty)!){
                isValid = true
            }else{
                msg = item.placeholder! + " es requerio"
                isValid = false
                break
            }
        }
        
        self.delegate?.onValidFields(isValid: isValid, msg: msg)
        
    }
}
