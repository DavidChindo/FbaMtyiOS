//
//  TmpDirectory.swift
//  FbMty
//
//  Created by David Barrera on 6/29/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class TmpDirectory: NSObject {
    
    class func clearTmpDirectory() {
        URLCache.shared.removeAllCachedResponses()
    }
    
}
