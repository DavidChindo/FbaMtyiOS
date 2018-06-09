//
//  StatusParkings.swift
//  FbMty
//
//  Created by David Barrera on 5/31/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class StatusParkings: NSObject {

    var title: String?
    var value:Int = 0
    
    init(title: String, value: Int) {
        self.title = title
        self.value = value
    }
    
    func statusParkings()->[StatusParkings]{
        var status:[StatusParkings] = []
        status.append(StatusParkings(title: "Todos", value: -1))
        status.append(StatusParkings(title: "Pendiente", value: 0))
        status.append(StatusParkings(title: "En Atención", value: 1))
        status.append(StatusParkings(title: "Autorizado", value: 2))
        status.append(StatusParkings(title: "Cancelado", value: 3))
        
        return status
    }
    
}
