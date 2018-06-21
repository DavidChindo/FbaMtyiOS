//
//  LoginPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Realm


class LoginPresenter: BasePresenter {

    var delegate: LoginDelegate?
    var request: Alamofire.Request?
    
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func login(grantType: String,username:String,password:String){
        
        let params: Parameters = ["grant_type" : grantType, "username" : username, "password" : password, "pushID" : "PUSIOS"]
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onLoginError(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_LOGIN, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseObject(completionHandler: {(response: DataResponse<LoginResponse>) in
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                            
                        case .success:
                            if statusCode == Constants.STATUS_OK{
                                RealmManager.insert(LoginResponse.self, item: response.result.value!)
                                self.delegate?.onLoginSuccess(loginResponse: response.result.value!)
                            }else{
                                self.delegate?.onLoginError(msg:  "Usuario o contraseña incorrectas")
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.onLoginError(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                self.delegate?.onLoginError(msg: error.localizedDescription)
            }
        }
        
    }

}
