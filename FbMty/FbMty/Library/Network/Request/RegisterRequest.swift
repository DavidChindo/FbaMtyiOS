//
//  RegisterRequest.swift
//  FbMty
//
//  Created by David Barrera on 5/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

class RegisterRequest: NSObject, Mappable {

    
    var email:String?
    var password:String?
    var confirmPassword:String?
    var rfc:String?
    var noClient:String?
    
    init(email: String?, password: String?, confirmPassword: String?, rfc: String?, noClient: String?) {
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
        self.rfc = rfc
        self.noClient = noClient
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        email <- map["Email"]
        password <- map["Password"]
        confirmPassword <- map["ConfirmPassword"]
        rfc <- map["RFC"]
        noClient <- map["NoCliente"]
    }

    
    
}
