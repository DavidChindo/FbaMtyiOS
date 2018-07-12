//
//  ResetPasswordPresenter.swift
//  FbMty
//
//  Created by David Barrera on 7/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class ResetPasswordPresenter: BasePresenter {

    var delegate: ResetPasswordDelegate?
    var request: Alamofire.Request?
    
    init(delegate: ResetPasswordDelegate) {
        self.delegate = delegate
    }
    
    func resetPassword(resetPasswordRequest: ResetPasswordRequest){
        let params = Mapper().toJSON(resetPasswordRequest)
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            self.delegate?.onSuccessResetPassword(msg:  "No hay conexión a Internet")
        case .online(.wwan),.online(.wiFi):
            do{
                try
                    request = Alamofire.request(Urls.API_resetPassword, method: .post, parameters: params, encoding:JSONEncoding.default, headers: nil).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                
                                self.delegate?.onSuccessResetPassword(msg: "Se ha enviado un enlace a su correo para recuperar su contraseña")
                            }else{
                                
                                self.delegate?.onErrorResetPassword(msg: "No se ha encontrado su correo electrónico")
                            }
                        
                    })
            }catch let error{
                print(error.localizedDescription)
                self.delegate?.onErrorResetPassword(msg: error.localizedDescription)
            }
        }
    }
}
