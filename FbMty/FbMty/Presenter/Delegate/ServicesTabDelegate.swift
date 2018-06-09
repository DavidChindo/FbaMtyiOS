//
//  ServicesTabDelegate.swift
//  FbMty
//
//  Created by David Barrera on 6/7/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

public protocol ServicesTabDelegate: NSObjectProtocol {

    
    func onOpenService(service: Service)
}
