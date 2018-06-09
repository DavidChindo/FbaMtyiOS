//
//  Service.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class Service: Object, Mappable {
    
    dynamic var id:Int = -1
    dynamic var title:String?
    dynamic var descriptionSer: String?
    dynamic var icon:String?
    dynamic var order:Int = -1
    dynamic var type:String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["Id"]
        title <- map["Title"]
        descriptionSer <- map["Description"]
        icon <- map["Icon"]
        order <- map["Order"]
        type <- map["type"]
    }

}
