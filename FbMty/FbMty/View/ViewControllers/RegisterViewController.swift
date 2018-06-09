//
//  RegisterViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/6/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner


class RegisterViewController: BaseViewController, RegisterDelegate,UITextFieldDelegate {

    
    @IBOutlet weak var numCleintTextField: UITextField!
    @IBOutlet weak var rfcTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var fields:[UITextField] = []
    
    
    var registerPresenter: RegisterPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextFieldDelegate()
        hideKeyboard()
        initViews()
        
        registerPresenter = RegisterPresenter(delegate: self)
        setupPresenter(registerPresenter!)
        
    }

    func initViews(){
        
        fields.append(emailTextField)
        fields.append(passwordTextField)
        fields.append(confirmTextField)
        fields.append(rfcTextField)
        fields.append(numCleintTextField)
    }

    @IBAction func onRegisterClick(_ sender: Any) {
        SwiftSpinner.show("Enviando...")
        registerPresenter?.valid(fields: fields)
    }
    
    @IBAction func onCloseRegisterClick(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }

    func onValidFields(isValid: Bool, msg: String?) {
        
        if isValid{
            registerPresenter?.validPassword(pass: passwordTextField, confirmPassword: confirmTextField)
        }else{
            SwiftSpinner.hide()
            DesignUtils.messageError(vc: self, title: "Validación", msg: msg!)
        }
    }
    
    func onValidPassword(isEquals: Bool, msg: String?) {
        
        if isEquals {
            let registerRequest = RegisterRequest(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmTextField.text, rfc: rfcTextField.text, noClient: numCleintTextField.text)
            registerPresenter?.register(registerRequest: registerRequest)
        }else{
            SwiftSpinner.hide()
            DesignUtils.messageError(vc: self, title: "Validación", msg: msg!)
        }
    }
    
    func onSuccessRegister(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirmFinish(titleMessage: "Registro", message: msg!, vc: self)
    }
    
    
    func onErrorRegister(msg: String?) {
        SwiftSpinner.hide()
        DesignUtils.alertConfirmFinish(titleMessage: "Error Registro", message: msg!, vc: self)
    }
    
    func initTextFieldDelegate(){
        numCleintTextField.delegate = self
        rfcTextField.delegate = self
        confirmTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            return true
        case passwordTextField:
            confirmTextField.becomeFirstResponder()
            return true
        case confirmTextField:
            rfcTextField.becomeFirstResponder()
            return true
        case rfcTextField:
            numCleintTextField.becomeFirstResponder()
            return true
        case numCleintTextField:
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
