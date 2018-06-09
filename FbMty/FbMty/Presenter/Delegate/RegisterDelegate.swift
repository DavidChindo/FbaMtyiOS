//
//  RegisterDelegate.swift
//  FbMty
//
//  Created by David Barrera on 5/24/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

public protocol RegisterDelegate: NSObjectProtocol {
    
    func onSuccessRegister(msg:String?);
    
    func onErrorRegister(msg:String?);
    
    func onValidFields(isValid:Bool,msg:String?);
    
    func onValidPassword(isEquals:Bool,msg:String?);

}
