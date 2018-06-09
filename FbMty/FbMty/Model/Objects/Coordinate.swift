//
//  Coordinate.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class Coordinate: Object,Mappable {
    
    dynamic var idHolding:Double = -1
    dynamic var latitude:Double = -1
    dynamic var longitude:Double = -1
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        idHolding <- map["IdHolding"]
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
    }

}
