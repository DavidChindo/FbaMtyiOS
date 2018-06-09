//
//  Picture.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm


open class Picture: Object,Mappable {

    dynamic var mediaId:Int = -1
    dynamic var HoldingId: Double = -1
    dynamic var Nombre:String?
    dynamic var Extension:String?
    dynamic var TipoMedio:String?
    dynamic var Path:String?
    dynamic var MediaAparicion:String?
    dynamic var id:Int = -1
    
    override open static func primaryKey()-> String?{
        return "mediaId"
    }
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        mediaId <- map["MediaId"]
        HoldingId <- map["HoldingId"]
        Nombre <- map["Nombre"]
        Extension <- map["Extension"]
        Path <- map["Path"]
        TipoMedio <- map["TipoMedio"]
        MediaAparicion <- map["MediaAparicion"]
    }
    
}
