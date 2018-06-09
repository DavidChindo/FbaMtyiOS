//
//  ServicesDescResponse.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper


open class ServicesDescResponse: NSObject, Mappable {
    
    var descriptionMsg: String?
    var availables:Int = -1
    var HoldingId:Double = -1
    var id:Double = -1
    var amountPrice:Int = -1
    var rentPrice:Int = -1
    var boxType:Int = -1
    var placeType: Int = -1
    var serviceEstType: Int = -1
    var cardType:Int = -1
    var total: Int = -1
    var userXcourtesies:Int = -1
    var userXAmounts:Int = -1
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    
    public func mapping(map: Map) {
        descriptionMsg <- map["Descripcion"]
        availables <- map["Disponibles"]
        HoldingId <- map["HoldingId"]
        id <- map["Id"]
        amountPrice <- map["PrecionMnto"]
        rentPrice <- map["PrecioRenta"]
        boxType <- map["TipoCajon"]
        placeType <- map["TipoLugar"]
        serviceEstType <- map["TipoServicioEst"]
        cardType <- map["TipoTarjeta"]
        total <- map["Total"]
        userXcourtesies <- map["CortesiasPorUsuario"]
        userXAmounts <- map["MntosPorUsuario"]
    }

}
