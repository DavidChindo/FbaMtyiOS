//
//  Contact.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class Contact: Object,Mappable {

    dynamic var name:String?
    var phones = List<Phone>()
    dynamic var email:String?
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        name <- map["Name"]
        phones <- map["phone"]
        email <- map["email"]
    }
}
