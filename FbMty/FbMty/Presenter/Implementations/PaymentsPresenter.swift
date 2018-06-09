//
//  PaymentsPresenter.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class PaymentsPresenter: BasePresenter {
    
    var delegate: PaymentsDelegate?
    var request: Alamofire.Request?
    
    
    init(delegate: PaymentsDelegate) {
        self.delegate = delegate
    }
    
    func payments(idHolding:Double){
        
        let authorization = "bearer "+RealmManager.token()
        let url = String(format: Urls.API_payments, idHolding)as String
        
        let status = Reach().connectionStatus()
        
        switch status {
            
        case .unknown,.offline:
            self.delegate?.onPaymentsError(msg:  "No hay conexión a Internet.")
            
        case .online(.wwan),.online(.wiFi):
            
            do {
                try
                    request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseArray(completionHandler: {(response: DataResponse<[Payments]>) in
                        
                        switch response.result{
                            
                        case .success:
                            let code = response.response?.statusCode
                            if code == Constants.STATUS_OK{
                                RealmManager.insert(Payments.self, items: response.result.value!)
                                self.delegate?.onPaymentsSuccess(payments: response.result.value!, isFilter: false)
                            }else{
                                self.delegate?.onPaymentsError(msg: response.description)
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            self.delegate?.onPaymentsError(msg:   error.localizedDescription)
                        }})
                
                
            } catch let error {
                print(error.localizedDescription)
                self.delegate?.onPaymentsError(msg:  error.localizedDescription)
            }
        }
    }

    func paymentsFilter(dateString: String, payment: String){
        if(!dateString.isEmpty && !payment.isEmpty){
            var paymentsloc: [Payments] = RealmManager.findPayments(Payments.self, value: dateString, value1: payment)
            self.delegate?.onPaymentsSuccess(payments: paymentsloc, isFilter: true)
        }
    }

}
