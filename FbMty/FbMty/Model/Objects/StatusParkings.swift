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
    
}
