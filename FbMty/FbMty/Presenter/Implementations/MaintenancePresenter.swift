//
//  MaintenancePresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper


class MaintenancePresenter: BasePresenter {
    
    var delegate: MaintenanceDelegate?
    var request: Alamofire.Request?
    
    init(delegate: MaintenanceDelegate) {
        self.delegate = delegate
    }

    func maintenances(idHolding:Int){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_maintenances, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onErrorMaintenance(msgError: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[Maintenance]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                self.delegate?.onLoadMaintenance(maintenances:  response.result.value!)
                            }else{
                                self.delegate?.onErrorMaintenance(msgError:  response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onErrorMaintenance(msgError:  error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onErrorMaintenance(msgError:  error.localizedDescription)
            }
        }
    }
    

    
}
