//
//  ProfileViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/11/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import BmoImageLoader

class ProfileViewController: BaseViewController,ProfileDelegate,UIPickerViewDelegate {
    
    @IBOutlet weak var holdingImg: UIImageView!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var holdingPicker: UIPickerView!
    @IBOutlet weak var userLbl: UILabel!
    
    var profilePresenter:ProfilePresenter?
    var holdings: [String] = []
    
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
    
    }

    func logoutSuccess(msg: String?) {
        
    }
    
    func logoutError(msg: String?) {
        
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
}
