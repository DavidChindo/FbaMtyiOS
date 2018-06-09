//
//  Maintenance.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class Maintenance: Object,Mappable {
    
    dynamic var title:String?
    dynamic var descriptionMa: String?
    dynamic var schedule:String?
    dynamic var frequency:String?
    dynamic var provider:String?
    dynamic var cost:String?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        title <- map["title"]
        descriptionMa <- map["description"]
        schedule <- map["schedule"]
        frequency <- map["frequency"]
        provider <- map["provider"]
        cost <- map["cost"]
    }
    
}
