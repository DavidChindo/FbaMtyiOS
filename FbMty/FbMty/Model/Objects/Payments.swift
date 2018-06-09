//
//  Payments.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class Payments: Object, Mappable {
    
    dynamic var documentNumber:String?
    dynamic var descriptionPay: String?
    dynamic var amount:String?
    dynamic var dateValidity:String?
    dynamic var dateAccounting:String?
    dynamic var status:String?
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        documentNumber <- map["documentNumber"]
        descriptionPay <- map["desciption"]
        amount <- map["amount"]
        dateValidity <- map["dateValidity"]
        dateAccounting <- map["dateAccounting"]
        status <- map["status"]
    }
}
