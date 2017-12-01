//
//  ActivityHolding.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class ActivityHolding: Object,Mappable {
    
    dynamic var id:Int = -1
    dynamic var dateStart:String?
    dynamic var dateEnd:String?
    dynamic var title:String?
    dynamic var descriptionAH: String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }

    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["Id"]
        dateStart <- map["dateStart"]
        dateEnd <- map["dateEnd"]
        title <- map["title"]
        descriptionAH <- map["description"]
    }
}
