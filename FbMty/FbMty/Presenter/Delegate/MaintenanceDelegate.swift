//
//  MaintenanceDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Realm

public protocol MaintenanceDelegate: NSObjectProtocol {
    
    func onLoadMaintenance(maintenances:[Maintenance]);
    
    func onErrorMaintenance(msgError:String?);

}
