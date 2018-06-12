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
    dynamic var name:String?
    dynamic var status:String?
    dynamic var currency:String?
    
    override open static func primaryKey()-> String?{
        return "documentNumber"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        documentNumber <- map["DOC_NO"]
        descriptionPay <- map["ITEM_TEXT"]
        amount <- map["AMT_DOCCUR"]
        dateValidity <- map["POSTING_DATE"]
        name <- map["DOC_TYPE"]
        status <- map["CLR_DOC_NO"]
        currency <- map["CURRENCY"]
    }
}
