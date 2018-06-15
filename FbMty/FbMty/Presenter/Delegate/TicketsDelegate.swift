//
//  TicketsDelegate.swift
//  FbMty
//
//  Created by David Barrera on 6/15/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

public protocol TicketsDelegate: NSObjectProtocol {

    func onOpenTicket(ticket: Service)
    
}
