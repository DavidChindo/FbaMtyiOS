//
//  ResetPasswordDelegate.swift
//  FbMty
//
//  Created by David Barrera on 7/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

public protocol ResetPasswordDelegate: NSObjectProtocol {

    func onSuccessResetPassword(msg: String)
    
    func onErrorResetPassword(msg: String)
}
