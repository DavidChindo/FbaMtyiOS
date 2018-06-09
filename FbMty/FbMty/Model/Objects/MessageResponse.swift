//
//  MessageResponse.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class MessageResponse: Object,Mappable {

    dynamic var id:Int = -1
    dynamic var holdingId:Double = -1
    dynamic var userId:String?
    dynamic var isResponse:Bool = false
    dynamic var sentDate:String?
    dynamic var viewed:Bool = false
    dynamic var message:String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }

    
    public func mapping(map: Map) {
        id <- map["Id"]
        holdingId <- map["HoldingId"]
        userId <- map["UserId"]
        isResponse <- map["isResponse"]
        sentDate <- map["FechaEnviado"]
        viewed <- map["Visto"]
        message <- map["Message"]
    }
}
