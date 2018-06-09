//
//  Phone.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class Phone: Object, Mappable {
    
    dynamic var number:String?
    dynamic var ext:String?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        number <- map["number"]
        ext <- map["ext"]
    }

}
