//
//  PaymentsDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Realm

public protocol PaymentsDelegate: NSObjectProtocol {
    
    func onPaymentsSuccess(payments:[Payments],isFilter: Bool);
    
    func onPaymentsError(msg:String?);

    func onOpenPayments(payment: Payments)
}
