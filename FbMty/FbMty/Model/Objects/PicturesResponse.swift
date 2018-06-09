//
//  PicturesResponse.swift
//  FbMty
//
//  Created by David Barrera on 5/23/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import Realm

open class PicturesResponse: Object, Mappable  {
 
      var baseMediaPath = List<Picture>()
      var busquedaImages = List<Picture>()
      var comercialImages = List<Picture>()
      var detalleImages = List<Picture>()
      var footerImages = List<Picture>()
      var videoImages = List<Picture>()
      var planosImages = List<Picture>()
      var zipOtros = List<Picture>()
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public  func mapping(map: Map) {
        var baseMediaPathA = Array<Picture>()
        var busquedaImagesA = Array<Picture>()
        var comercialImagesA = Array<Picture>()
        var detalleImagesA = Array<Picture>()
        var footerImagesA = Array<Picture>()
        var videoImagesA = Array<Picture>()
        var planosImagesA = Array<Picture>()
        var zipOtrosA = Array<Picture>()
        
        baseMediaPathA <- map["baseMediaPath"]
        busquedaImagesA <- map["busquedaImages"]
        comercialImagesA <- map["comercialImages"]
        detalleImagesA <- map["detalleImages"]
        footerImagesA <- map["footerImages"]
        videoImagesA <- map["videoImages"]
        planosImagesA <- map["planosImages"]
        zipOtrosA <- map["zipOtros"]
        
        
        for conn in baseMediaPathA {
            baseMediaPath.append(conn)
        }
        for conn1 in busquedaImagesA {
            busquedaImages.append(conn1)
        }
        for conn2 in comercialImagesA {
            comercialImages.append(conn2)
        }
        for conn3 in detalleImagesA {
            detalleImages.append(conn3)
        }
        for conn4 in footerImagesA {
            footerImages.append(conn4)
        }
        for conn5 in videoImagesA {
            videoImages.append(conn5)
        }
        for conn6 in planosImagesA {
            planosImages.append(conn6)
        }
        for conn7 in zipOtrosA {
            zipOtros.append(conn7)
        }
    }

    
}

