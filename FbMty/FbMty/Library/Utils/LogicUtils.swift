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
    
    class func validateTextField(textField: UITextField) -> Bool{
        return !(textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)!
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
            dateFormatter.locale = Locale(identifier: "es_MX")
            let date = dateFormatter.date(from: stringDate)
            dateFormatter.dateFormat = "dd MMM yyyy"
            let publishDate = dateFormatter.string(from: date!)
            return publishDate
        }else{
            return ""
        }
        
        /*
         formatter.locale = Locale(identifier: "en_US_POSIX")

         
 let dateFormatterGet = DateFormatter()
 dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
 
 let dateFormatterPrint = DateFormatter()
 dateFormatterPrint.dateFormat = "MMM dd,yyyy"
 
 if let date = dateFormatterGet.date(from: "2016-02-29 12:24:26"){
 print(dateFormatterPrint.string(from: date))
 }
         
 else {
 print("There was an error decoding the string")
 }
 
         func getFormattedDate(string: String , formatter:String) -> String{
         let dateFormatterGet = DateFormatter()
         dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         
         let dateFormatterPrint = DateFormatter()
         dateFormatterPrint.dateFormat = "MMM dd,yyyy"
         
         let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
         print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
         return dateFormatterPrint.string(from: date!);
         }
         
 */
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
