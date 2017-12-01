//
//  Office.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class Office: Object,Mappable {
    
    dynamic var id:Int = -1
    dynamic var totalArea:String?
    dynamic var priceSquareMeter:String?
    dynamic var priceOffice:String?
    dynamic var type:String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["Id"]
        totalArea <- map["totalArea"]
        priceSquareMeter <- map["priceSquareMeter"]
        priceOffice <- map["priceOffice"]
        type <- map["type"]
    }

}
