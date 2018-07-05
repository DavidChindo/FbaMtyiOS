//
//  ProfileViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/11/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import BmoImageLoader
import SwiftSpinner

class ProfileViewController: BaseViewController,ProfileDelegate,UIPickerViewDelegate {
    
    @IBOutlet weak var holdingImg: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var holdingPicker: UIPickerView!
    @IBOutlet weak var userLbl: UILabel!
    
    var profilePresenter:ProfilePresenter?
    var holdings: [String] = []
    var window:UIWindow?
    
    var loginViewController = "LoginViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        profilePresenter = ProfilePresenter(delegate: self)
        setupPresenter(profilePresenter!)
        
    }
    
    func initViews(){
        self.navigationController?.isNavigationBarHidden = true
        holdings = RealmManager.holdingsName()
        userLbl.text = RealmManager.user()
        holdingPicker.delegate = self
        holdingPicker.selectRow(Prefs.instance().integer(Keys.PREF_POSITION_SELECTED), inComponent: 0, animated: true)
        reloadImage()
        BmoImageViewFactory.shape(holdingImg, shape: BmoImageViewShape.roundedRect(corner: 4))
        
    }
    
    @IBAction func onLogoutClick(_ sender: Any) {
    
        let alertEmpty = UIAlertController(title: "Cerrar Sesión", message: "¿Desea cerrar sesión?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertEmpty.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action:UIAlertAction!) in
            SwiftSpinner.show("Cerrando Sesión...")
            self.profilePresenter?.logOut()
        }))
        
        alertEmpty.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: {(action:UIAlertAction!) in
            alertEmpty.dismiss(animated: true, completion: nil)
        }))
        
        present(alertEmpty, animated: true, completion: nil)
        
    }

    func logoutSuccess(msg: String?) {
        SwiftSpinner.hide()
        Prefs.instance().putInt(Keys.PREF_POSITION_SELECTED, value: 0)
        Prefs.instance().putBool(Keys.PREF_LOGIN, value: false)
        Prefs.instance().putBool(Keys.PREF_LOADING, value: false)
        TmpDirectory.clearTmpDirectory()
        initView(idView: loginViewController)
    }
    
    func logoutError(msg: String?) {
        SwiftSpinner.hide()
        
        DesignUtils.alertConfirm(titleMessage: "Sesión", message: msg!, vc: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return holdings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return holdings[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Prefs.instance().putInt(Keys.PREF_POSITION_SELECTED, value: row)
        MenuViewController.holdingResponse = MenuViewController.holdingResponses[row]
        reloadImage()
    }
    
    func reloadImage(){
        let url = URL(string: DesignUtils.getUrlImage(holding: MenuViewController.holdingResponse!))
        holdingImg.bmo_setImageWithURL(url!, style: .circleBrush(borderShape: false))
    }
    
    func initView(idView:String){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: idView)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initViews()
    }
}
