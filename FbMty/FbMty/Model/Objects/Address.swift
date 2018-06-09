//
//  Address.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class Address: Object, Mappable {
    
    dynamic var idHolding:Double = -1
    dynamic var street:String?
    dynamic var numberInt:String?
    dynamic var numberExt:String?
    dynamic var suburb:String?
    dynamic var town:String?
    dynamic var state:String?
    dynamic var zip:String?
    dynamic var idState:Double = -1

    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public  func mapping(map: Map) {
        idHolding <- map["IdHolding"]
        street <- map["Street"]
        numberInt <- map["NumberInt"]
        numberExt <- map["NumberExt"]
        suburb <- map["Suburb"]
        town <- map["Town"]
        state <- map["State"]
        zip <- map["ZIP"]
        idState <- map["IdState"]
    }
    
}
