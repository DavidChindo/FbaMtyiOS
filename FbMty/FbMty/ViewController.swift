//
//  ViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner

class ViewController: BaseViewController, LoginDelegate,HoldingDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var window:UIWindow?
    var loginPresenter:LoginPresenter?
    var holdingPresenter: HoldingPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter = LoginPresenter(delegate: self)
        holdingPresenter = HoldingPresenter(delegate: self)
        setupPresenter(loginPresenter!)
        setupPresenter(holdingPresenter!)
        initTextFieldDelegate()
        hideKeyboard()
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        
        login()
    }
    
    @IBAction func onRegisterClick(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterID") else {
            print("View controller Six not found")
            return
        }
        present(vc, animated: true, completion: nil)

    }
    
    @IBAction func onForgetPassClick(_ sender: Any) {
    
    }
    
    func initView(idView:String){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: idView)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    func onLoginSuccess(loginResponse: LoginResponse) {
        if LogicUtils.isObjectNotNil(object: loginResponse){
            SwiftSpinner.sharedInstance.titleLabel.text = "Descargando..."
            holdingPresenter?.holding()
        }
    }
    
    func onLoginError(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirm(titleMessage: "Error Credenciales", message: msg!, vc: self)
    }
    
    func onDownloadHolding(holdingResponses: [HoldingResponse]) {
        SwiftSpinner.hide()
        if LogicUtils.isObjectNotNil(object: holdingResponses as AnyObject) && holdingResponses.count > 0{
            Prefs.instance().putBool(Keys.PREF_LOGIN, value: true)
            Prefs.instance().putBool(Keys.PREF_LOADING, value: false)
            //RealmManager.insert(HoldingResponse.self, items: holdingResponses)
            MenuViewController.holdingResponses = holdingResponses
//            MenuViewController.holdingResponse = holdingResponses[Prefs.instance().integer(Keys.PREF_POSITION_SELECTED)]
            MenuViewController.holdingResponse = holdingResponses[1]
            initView(idView: "MenuTabViewController")
        }else{
            DesignUtils.alertConfirmFinish(titleMessage: "Ingreso", message: "No tiene ningún edificio contratado", vc: self)
        }
        
    }
    
    func onDownloadError(msg: String?) {
        SwiftSpinner.hide()
         DesignUtils.alertConfirmFinish(titleMessage: "Descarga", message: msg!, vc: self)
    }
    
    func login(){
        let user = usernameTxtField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let password = passwordTxtField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let msgValidate: String = DesignUtils.validateCredentials(username: user!, password: password!)
        
        if msgValidate.isEmpty {
            SwiftSpinner.show("Autenticando...")
            loginPresenter?.login(grantType: "password", username: user!, password: password!)
    
        }else{
              DesignUtils.alertConfirm(titleMessage: "Ingreso", message: msgValidate, vc: self)
        }
    }
    
    func initTextFieldDelegate(){
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTxtField:
            passwordTxtField.becomeFirstResponder()
            return true
        case passwordTxtField:
            dismissKeyboard()
            return true
        default:
            return true
        }
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

