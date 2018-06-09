//
//  ProfilePresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ProfilePresenter: BasePresenter {

    var delegate: ProfileDelegate?
    var request: Alamofire.Request?
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
    
    func logOut(){
    
        let authorization = "bearer "+RealmManager.token()
        
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.logoutError(msg:  "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_LOGOUT, method: .post, parameters: nil, encoding: URLEncoding.default, headers: ["Authorization" : authorization]).responseJSON(completionHandler: {(response: DataResponse<Any>) in
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result{
                            
                        case .success:
                            if statusCode == 200{
                                self.delegate?.logoutSuccess(msg: "Sesión Finalizada")
                            }else{
                                self.delegate?.logoutError(msg:  response.description)
                            }
                        case .failure(let error):
                            print(error)
                            self.delegate?.logoutError(msg:  error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error)
                delegate?.logoutError(msg: error.localizedDescription)
            }
        }
        
    }
}
