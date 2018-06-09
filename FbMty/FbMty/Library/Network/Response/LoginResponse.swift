//
//  LoginResponse.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class LoginResponse: Object, Mappable {

    dynamic var token:String?
    dynamic var tokenType:String?
    dynamic var username:String?
    dynamic var rfc:String?
    dynamic var roles:String?
    dynamic var expireDate:String?
    
    override open static func primaryKey()-> String?{
        return "username"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        token <- map["access_token"]
        tokenType <- map["token_type"]
        username <- map["userName"]
        rfc <- map["RFC"]
        roles <- map["Roles"]
        expireDate <- map[".expires"]
    }
    
}

 
