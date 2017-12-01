//
//  Ticket.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class Ticket: Object, Mappable {

    dynamic var id:Int = -1
    dynamic var title:String?
    dynamic var descriptionTicket: String?
    dynamic var order:String?
    dynamic var ticketKey:String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        descriptionTicket <- map["description"]
        order <- map["order"]
        ticketKey <- map["cveTicket"]
    }
    
}
