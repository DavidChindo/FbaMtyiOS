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
    dynamic var id:Int = -1
    dynamic var HoldingId: Int = -1
    dynamic var ProviderPhone:String?
    dynamic var ProviderCellPhone:String?
    dynamic var ProviderEmail:String?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        title <- map["Title"]
        descriptionMa <- map["Description"]
        schedule <- map["Schedule"]
        frequency <- map["frequency"]
        provider <- map["ProviderName"]
        cost <- map["Cost"]
        ProviderPhone <- map["ProviderPhone"]
        ProviderCellPhone <- map["ProviderCellPhone"]
        ProviderEmail <- map["ProviderEmail"]
        id <- map["Id"]
        HoldingId <- map["HoldingId"]
    }
    
}
