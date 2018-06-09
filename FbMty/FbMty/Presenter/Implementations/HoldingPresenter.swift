//
//  HoldingPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/25/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Realm


class HoldingPresenter: BasePresenter {
    
    var delegate: HoldingDelegate?
    var request: Alamofire.Request?
    
    init(delegate: HoldingDelegate) {
        self.delegate = delegate
    }

    func holding(){
        
        let authorization = "bearer "+RealmManager.token()
        
        let status = Reach().connectionStatus()
        
        switch status {
        case .unknown,.offline:
            self.delegate?.onDownloadError(msg: "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(Urls.API_holdingByUser, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response : DataResponse<[HoldingResponse]>) in
                        
                        switch response.result{
                        
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                              self.delegate?.onDownloadHolding(holdingResponses: response.result.value!)
                            }else{
                                self.delegate?.onDownloadError(msg: response.result.description)
                            }
                        
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onDownloadError(msg: error.localizedDescription)
                        }
                    })
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onDownloadError(msg: error.localizedDescription)
            }
        
        }
    
    }
    
}
