//
//  MyTicketResponse.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class MyTicketResponse: Object, Mappable {

    dynamic var status:String?
    dynamic var updateDate:String?
    dynamic var requestDate:String?
    dynamic var filePath:String?
    dynamic var holdingId:Double = -1
    dynamic var id:Int = -1
    dynamic var observationsAdmin:String?
    dynamic var observationsUser:String?
    dynamic var ticket:Double = -1
    dynamic var userId:String?
    dynamic var descriptionMsg:String?
    
    override open static func primaryKey()-> String?{
        return "id"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        status <- map["Estatus"]
        updateDate <- map["FechaActualizacion"]
        requestDate <- map["FechaSolicitud"]
        filePath <- map["FilePath"]
        holdingId <- map["HoldingId"]
        id <- map["Id"]
        observationsAdmin <- map["ObservacionesAdmin"]
        observationsUser <- map["ObservacionesUsuario"]
        ticket <- map["ServiceId"]
        userId <- map["UserId"]
        descriptionMsg <- map["ServiceDesc"]
    }
}

