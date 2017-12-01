//
//  ChatRequest.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

public class ChatRequest: NSObject,Mappable {
    
    var name:String?
    var title:String?
    var message:String?
    var reason:String?
    var idHolding:Int = -1
    
    public init(name:String, title:String, message:String, reason: String, idHolding: Int) {
        self.name = name
        self.title = title
        self.message = message
        self.reason = reason
        self.idHolding = idHolding
    }
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        title <- map["title"]
        message <- map["message"]
        reason <- map["reason"]
        idHolding <- map["idHolding"]
    }

}

