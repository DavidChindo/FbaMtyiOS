//
//  HoldingResponse.swift
//  FbMty
//
//  Created by David Barrera on 5/23/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class HoldingResponse: Object, Mappable {

    dynamic var administrador:String?
    dynamic var AdministradorMail:String?
    dynamic var AdministradorNumero: String?
    dynamic var Id:Int = -1
    dynamic var IdParentHolding:Int = -1
    dynamic var IdSAP:String?
    dynamic var NombreEdificio:String?
    dynamic var Coordinates:Coordinate?
    dynamic var Address:Address?
    dynamic var AniosContruccion:Int = -1
    dynamic var AreaTotal:String?
    dynamic var OfficesQty:Int = -1
    dynamic var Arquitecto:String?
    dynamic var Descripcion:String?
    dynamic var TipoPropiedad:Int = -1
    dynamic var PrecioTotal:String?
    dynamic var officeObj:Office?
    dynamic var Picture:PicturesResponse?
    var ServiceTickets = List<Service>()
    var ActivityHolding = List<ActivityHolding>()
    dynamic var avaiableOffices:Int = -1
    var plans = List<Plan>()
    dynamic var Estacionamientos: Int  = -1
    dynamic var Contact:Contact?
    dynamic var HoldingExtraProperties:String?
    dynamic var architecturalPreview:String?
    var ServicesAdmin = List<Service>()
    var OtrosList:[String] = []
    dynamic var UrlVideo:String?
    
    
    override open static func primaryKey()-> String?{
        return "Id"
    }
    
    override open static func ignoredProperties() -> [String] {
        return ["OtrosList"]
    }
    
    public required  convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        var ServiceTicketsA = Array<Service>()
        var ActivityHoldingA = Array<ActivityHolding>()
        var plansA = Array<Plan>()
        var ServicesAdminA = Array<Service>()
        var OtrosListA = Array<String>()
        
        administrador <- map["Administrador"]
        AdministradorMail <- map["AdministradorMail"]
        AdministradorNumero <- map["AdministradorNumero"]
        Id <- map["Id"]
        IdParentHolding <- map["IdParentHolding"]
        IdSAP <- map["IdSAP"]
        NombreEdificio <- map["NombreEdificio"]
        Coordinates <- map["Coordinates"]
        Address <- map["Address"]
        AniosContruccion <- map["AniosContruccion"]
        AreaTotal <- map["AreaTotal"]
        OfficesQty <- map["OfficesQty"]
        Arquitecto <- map["Arquitecto"]
        Descripcion <- map["Descripcion"]
        TipoPropiedad <- map["TipoPropiedad"]
        PrecioTotal <- map["PrecioTotal"]
        officeObj <- map["officeObj"]
        Picture <- map["Picture"]
        ServiceTicketsA <- map["ServiceTickets"]
        ActivityHoldingA <- map["ActivityHolding"]
        avaiableOffices <- map["avaiableOffices"]
        plansA <- map["planosImages"]
        Estacionamientos <- map["Estacionamientos"]
        Contact <- map["Contact"]
        HoldingExtraProperties <- map["HoldingExtraProperties"]
        architecturalPreview <- map["architecturalPreview"]
        ServicesAdminA <- map["ServicesAdmin"]
        OtrosListA <- map["OtrosList"]
        UrlVideo <- map["UrlVideo"]
        
        for conn in ServiceTicketsA {
            ServiceTickets.append(conn)
        }
        for conn in ActivityHoldingA {
            ActivityHolding.append(conn)
        }
        for conn in plansA {
            plans.append(conn)
        }
        for conn in ServicesAdminA {
            ServicesAdmin.append(conn)
        }
        for conn in ServiceTicketsA {
            ServiceTickets.append(conn)
        }
        for conn in OtrosListA {
            OtrosList.append(conn)
        }
        
        
    }
    
}
