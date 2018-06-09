//
//  Provider.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class Provider: Object, Mappable {

    dynamic var name:String?
    dynamic var phone:String?
    dynamic var mobile:String?
    dynamic var email:String?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        name <- map["Name"]
        phone <- map["phone"]
        mobile <- map["mobile"]
        email <- map["email"]
    }
    
}
