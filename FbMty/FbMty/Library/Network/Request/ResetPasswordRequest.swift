//
//  ResetPasswordRequest.swift
//  FbMty
//
//  Created by David Barrera on 7/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

class ResetPasswordRequest: NSObject, Mappable {

    var email:String?

    init(email: String?){
        self.email = email
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        email <- map["Email"]
    }
}
