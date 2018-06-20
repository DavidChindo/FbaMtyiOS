//
//  MyTicketsDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

public protocol MyTicketsDelegate: NSObjectProtocol {

    
    func onSuccessMyTickets(ticketResponses:[MyTicketResponse]);
    
    func onErrorMyTickets(msg:String?);
    
    func onSuccessCancel(msg:String?);
    
    func onErrorCancel(msg:String?);
    
    func onSuccessDelete(msg:String?);
    
    func onErrorDelete(msg:String?);
    
    func onOpenMyTicket(myTicket: MyTicketResponse?)
    
}
