//
//  ParkingsInboxDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Realm

public protocol ParkingsInboxDelegate: NSObjectProtocol {

    
    func onLoadServicesData(servicesDataResponses:[ServicesDataResponse]);
    
    func onErrorServicesData(msg:String?);
    
}
