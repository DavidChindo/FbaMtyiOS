//
//  LogicUtils.swift
//  FbMty
//
//  Created by David Barrera on 6/1/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class LogicUtils: NSObject {
    
    class func validateString(word:String?)->Bool{
        if let wordTemp = word{
            return true
        }else{
            return false
        }
    }
    
    class func validateStringByString(word: String?)->String{
        if let wordTemp = word{
            return wordTemp
        }else{
            return ""
        }
    }
    
    class func alertConfirm(titleMessage:String, message:String,vc:UIViewController){
        
        let alertEmpty = UIAlertController(title: titleMessage, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertEmpty.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action:UIAlertAction!) in
            
        }))
        
        vc.present(alertEmpty, animated: true, completion: nil)
        
    }
    

    class func formatterDateMiliseconds(stringDate: String) -> String{
        //stringDate = "2017-07-03"
        if validateString(word: stringDate){
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"//"SS" // //
            let date = dateFormatter.date(from: stringDate)
            dateFormatter.dateFormat = "dd MMM yyyy"
            let publishDate = dateFormatter.string(from: date!)
            return publishDate
        }else{
            return ""
        }
    }
    
    class func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }
        
        return false
    }
    
}
