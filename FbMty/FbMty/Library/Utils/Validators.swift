//
//  Validators.swift
//  FbMty
//
//  Created by David Barrera on 5/25/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class Validators: NSObject {

    class func validateTextField(textField: UITextField) -> Bool{
        return !(textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)!
    }
    
    class func validateUITextView(textField: UITextView) -> Bool{
        return !(textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)!
    }
    
    
}
