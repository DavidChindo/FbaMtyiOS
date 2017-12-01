//
//  Picture.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class Picture: Object,Mappable {

    dynamic var id:Int = -1
    dynamic var size:Int = -1
    dynamic var url:String?
    dynamic var order:Int = -1
    dynamic var descriptionPic: String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["Id"]
        size <- map["size"]
        url <- map["url"]
        order <- map["order"]
        descriptionPic <- map["description"]
    }
    
}
