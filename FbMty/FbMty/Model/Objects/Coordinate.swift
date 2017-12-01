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
    
    dynamic var latitude:Double = -1
    dynamic var longitude:Double = -1
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }

}
