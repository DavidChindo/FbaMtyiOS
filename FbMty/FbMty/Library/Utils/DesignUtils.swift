//
//  DesignUtils.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import SpaceView

class DesignUtils: NSObject {
    
    static let darkPrimary = UIColor(red: 92/255, green: 193/255, blue: 220/255, alpha: 1)
    static let grayStatus = UIColor(red: 187/255, green: 189/255, blue: 191/255, alpha: 1)
    static let redBio = UIColor(red: 160/255, green: 43/255, blue: 66/255, alpha: 1)
    static let backGroundColor = UIColor(red: 240/255, green: 242/255, blue: 247/255, alpha: 1)
    static let grayFont = UIColor(red: 88/255, green: 89/255, blue: 91/255, alpha: 1)
    static let primaryDark = UIColor(red: 16/255, green: 40/255, blue: 58/255, alpha: 1)
    
    class func setBorder(button: UIButton,mred:Int,mgreen:Int,mblue:Int){
        button.layer.borderColor = UIColor(red: CGFloat(mred)/255, green: CGFloat(mgreen)/255, blue: CGFloat(mblue)/255, alpha: 1).cgColor
        button.layer.borderWidth = 1.0 
    }
    
    class func setBorderView(view: UIView,mred:Int,mgreen:Int,mblue:Int){
        view.layer.borderColor = UIColor(red: CGFloat(mred)/255, green: CGFloat(mgreen)/255, blue: CGFloat(mblue)/255, alpha: 1).cgColor
        view.layer.borderWidth = 1.0
    }
    
    class func alertConfirm(titleMessage:String, message:String,vc:UIViewController){
        
        let alertEmpty = UIAlertController(title: titleMessage, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertEmpty.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action:UIAlertAction!) in
            
        }))
        
        vc.present(alertEmpty, animated: true, completion: nil)
        
    }
    
    class func alertConfirmFinish(titleMessage:String, message:String,vc:UIViewController){
        
        let alertEmpty = UIAlertController(title: titleMessage, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertEmpty.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action:UIAlertAction!) in
            vc.dismiss(animated: true, completion: nil)
        }))
        
        vc.present(alertEmpty, animated: true, completion: nil)
        
    }
    
    
    class func messageError(vc:UIViewController, title: String, msg: String){
        vc.self.showSpace(title: title, description: msg, spaceOptions: [.spaceStyle(style: .error ),.spaceHeight(height: 80)
            ])
        
    }
    
    class func messageSuccess(vc:UIViewController, title: String, msg: String){
        vc.self.showSpace(title: title, description: msg, spaceOptions: [.spaceStyle(style: .success ),.spaceHeight(height: 80)
            ])
    }
    
    class func messageWarning(vc: UIViewController, title: String, msg: String){
        vc.self.showSpace(title: title, description: msg, spaceOptions: [.spaceStyle(style: .warning),.spaceHeight(height: 80)])
    }
    
    class func containerRound(content: UIView){
        content.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        content.layer.masksToBounds = false
        content.layer.cornerRadius = 3.0
        content.layer.shadowOffset = CGSize(width: -1, height: 1)
        content.layer.shadowOpacity = 0.2
        
    }
    
    class func containerRoundWithReturn(content: UIView)->UIView{
        content.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        content.layer.masksToBounds = false
        content.layer.cornerRadius = 3.0
        content.layer.shadowOffset = CGSize(width: -1, height: 1)
        content.layer.shadowOpacity = 0.2
        
        return content
    }
    
    class func numberFormat(numberd: Double)-> String{
        let formater = NumberFormatter()
        formater.groupingSeparator = ","
        formater.numberStyle = .decimal
        let valueFormated = formater.string(from: NSNumber(value: numberd))
        return valueFormated!
    }
    
    class func validateCredentials(username: String, password: String)-> String{
        if username.isEmpty && password.isEmpty {
            return "Favor de ingresar usuario y contraseña"
        }else{
            if !username.isEmpty {
                if !password.isEmpty {
                    return "";
                }else {
                    return "La contraseña es requerida"
                }
            }else{
                return "El usuario es requerido"
            }
        }
    }
 
    class func getUrlImage(holding:HoldingResponse)->String{
        var url:String = ""
        if LogicUtils.isObjectNotNil(object: holding) && LogicUtils.isObjectNotNil(object:holding.Picture) {
            if (holding.Picture?.comercialImages.count)! > 0 {
                url = Urls.API_FBMTY + (holding.Picture?.comercialImages[0].Path)!
            }
        }
        return url
    }

}
