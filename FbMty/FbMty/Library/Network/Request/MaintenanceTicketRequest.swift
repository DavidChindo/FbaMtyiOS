//
//  MaintenanceTicketRequest.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import ObjectMapper

public class MaintenanceTicketRequest: NSObject, Mappable {

    var idHolding:Int = -1

    public init(idHolding: Int) {
        self.idHolding = idHolding
    }
    
    public required init?(map: Map) {
        
    }
    
    public mutating func mapping(map: Map) {
        idHolding <- map["idHolding"]
    }
}
