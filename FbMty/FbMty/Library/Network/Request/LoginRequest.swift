//
//  LoginRequest.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

public class LoginRequest: NSObject,Mappable {
    
    var username:String?
    var password:String?
    var pushid:String?
    
    public init(username:String, password: String, pushId: String) {
        self.username = username
        self.password = password
        self.pushid = pushId
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        username <- map["usuario"]
        password <- map["contrasena"]
        pushid <- map["pushId"]
    }

}
