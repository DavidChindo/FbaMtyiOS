//
//  TicketDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

public protocol TicketDelegate: NSObjectProtocol {
    
    func onSentTicketSuccess(msg:String?);
    
    func onSentTicketError(msg:String?);

}
