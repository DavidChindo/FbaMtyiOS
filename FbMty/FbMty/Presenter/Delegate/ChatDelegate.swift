//
//  ChatDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import Realm

public protocol ChatDelegate: NSObjectProtocol {

    func onLoadMessages(messages:[MessageResponse])

    func onErrrorMessages(msg:String?)
    
    func onSuccessSentMessage(isSent:Bool)
    
    func onErrorSentMessage(msg:String?)
    
    func onValid(isValid:Bool,msg:String?);
    
}

