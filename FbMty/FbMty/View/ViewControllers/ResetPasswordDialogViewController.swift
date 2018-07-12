//
//  ResetPasswordDialogViewController.swift
//  FbMty
//
//  Created by David Barrera on 7/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
import STPopup

class ResetPasswordDialogViewController: BaseViewController,ResetPasswordDelegate {
    
    @IBOutlet weak var emailTxt: UITextField!

    var resetPasswordPresenter: ResetPasswordPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.contentSizeInPopup = CGSize(width: 300, height: 150)
        self.landscapeContentSizeInPopup = CGSize(width: 300, height: 150)

    }
    
    func initViews(){
        resetPasswordPresenter = ResetPasswordPresenter(delegate: self)
        setupPresenter(resetPasswordPresenter)
    }
    
    @IBAction func onResetPasswordClick(_ sender: Any) {
        if LogicUtils.validateTextField(textField: emailTxt){
            if isValidEmailAddress(emailAddressString: emailTxt.text!){
                SwiftSpinner.show("Enviando...")
                let recoveryPasswd = ResetPasswordRequest(email: (emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
                resetPasswordPresenter?.resetPassword(resetPasswordRequest: recoveryPasswd)
                
            }else{
                DesignUtils.messageError(vc: self, title: "Recuperar Contraseña", msg: "Formato de correo incorrecto. Intente nuevamente")
            }
        }else{
            DesignUtils.messageError(vc: self, title: "Recuperar Contraseña", msg: "Favor de ingresar correo electrónico")
        }
    }

    func onSuccessResetPassword(msg: String) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirmFinish(titleMessage: "Exitoso", message: msg, vc: self)
    }
    
    func onErrorResetPassword(msg: String) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirmFinish(titleMessage: "Error", message: msg, vc: self)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }

}
