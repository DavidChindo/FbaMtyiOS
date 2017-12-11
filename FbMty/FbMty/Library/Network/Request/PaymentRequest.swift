//
//  PaymentRequest.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

public class PaymentRequest: NSObject,Mappable {

    var month:String?
    var year:String?
    var idHolding:Int = -1
    
    public init(month:String, year:String, idHolding: Int) {
        self.month = month
        self.year = year
        self.idHolding = idHolding
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        month <- map["month"]
        year <- map["year"]
        idHolding <- map["idHolding"]
    }
}
