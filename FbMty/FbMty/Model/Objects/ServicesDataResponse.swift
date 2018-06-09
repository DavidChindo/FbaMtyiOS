//
//  ServicesDataResponse.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

open class ServicesDataResponse: NSObject,Mappable {
    
    var status:Int = -1
    var updateDate:String?
    var holdingId:Double = -1
    var id:Double = -1
    var requestDate:String?
    var courtesiesNum:Int = -1
    var ParkingHoldingId:Double = -1
    var courtesiesPrice:Int = -1
    var courtesiesTotalPrice:Double = -1
    var userId:String?
    var maintenanceNum:Int = -1
    var maintenancePrice:Int = -1
    var maintenanceTotalPrice: Double = -1
    var option:Int = -1
    
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        status <- map["Estatus"]
        updateDate <- map["FechaActualizacion"]
        holdingId <- map["HoldingId"]
        id <- map["Id"]
        requestDate <- map["FechaSolicitud"]
        courtesiesNum <- map["NumCortesias"]
        ParkingHoldingId <- map["ParkingHoldingId"]
        courtesiesPrice <- map["PrecioCortesia"]
        courtesiesTotalPrice <- map["PrecioTotalCortesia"]
        userId <- map["UserId"]
        maintenanceNum <- map["NumMantenimientos"]
        maintenancePrice <- map["PrecioMantenimiento"]
        maintenanceTotalPrice <- map["PrecioTotalMantenimiento"]
        option <- map["TipoAccion"]
    }

}
