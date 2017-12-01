//
//  Plan.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class Plan: Object,Mappable {
    
    dynamic var id:Int = -1
    dynamic var url:String?
    dynamic var type:String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["Id"]
        url <- map["url"]
        type <- map["type"]
    }
}
