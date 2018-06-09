//
//  ParkingsRequestDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

public protocol ParkingsRequestDelegate: NSObjectProtocol {
    
    func onLoadServicesParkings(servicesDescResponses:[ServicesDescResponse]);
    
    func onErrorServicesParkings(msgError:String?);
    
    func onSuccessSubmitTicketService(msg:String?);
    
    func onErrorSubmitTicketService(msg:String?);
    
    func onReloadServicesList();

}
