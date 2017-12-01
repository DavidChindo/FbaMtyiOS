//
//  RecoveryPasswordRequest.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

public class RecoveryPasswordRequest: NSObject,Mappable {

    var email:String?
    
    public init(email:String) {
        self.email = email
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        email <- map["email"]
    }
    
}
