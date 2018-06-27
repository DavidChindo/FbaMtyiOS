//
//  MenuViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftSpinner

class MenuViewController: BaseViewController,HoldingDelegate {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var paysTicket: UIView!
    @IBOutlet weak var paysView: UIView!
    @IBOutlet weak var multimediaView: UIView!
    @IBOutlet weak var maintenainceView: UIView!
    
    static var holdingResponses:[HoldingResponse] = []
    static var holdingResponse:HoldingResponse?
    
    var holdingPresenter: HoldingPresenter?
    
    var window: UIWindow?
    var loginViewController = "LoginViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Prefs.instance().bool(Keys.PREF_LOADING) {
            initViews()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Prefs.instance().bool(Keys.PREF_LOADING) {
            holdingPresenter = HoldingPresenter(delegate: self)
            setupPresenter(holdingPresenter!)
            
            SwiftSpinner.show("Descargando")
            holdingPresenter?.holding()
        }
        
    }
    
    
    func onDownloadHolding(holdingResponses: [HoldingResponse]) {
        SwiftSpinner.hide()
        if LogicUtils.isObjectNotNil(object: holdingResponses as AnyObject) && holdingResponses.count > 0{
            Prefs.instance().putBool(Keys.PREF_LOADING, value: false)
            
            MenuViewController.holdingResponses = holdingResponses
            //            MenuViewController.holdingResponse = holdingResponses[Prefs.instance().integer(Keys.PREF_POSITION_SELECTED)]
            MenuViewController.holdingResponse = holdingResponses[1]
            initViews()
        }else{
            DesignUtils.alertConfirmFinish(titleMessage: "Ingreso", message: "No tiene ningún edificio contratado", vc: self)
        }
        
    }
    
    func onDownloadError(msg: String?) {
        SwiftSpinner.hide()
        if msg == "salir" {
            initView(idView: loginViewController)
        }else{
            DesignUtils.alertConfirmFinish(titleMessage: "Descarga", message: msg!, vc: self)
        }
    }
    
    @IBAction func onOpenTicketClick(_ sender: Any) {
    
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ticketNavigation")
        self.present(destination!, animated: true, completion: nil)
    }
    
    @IBAction func onOpenMaintenanceClick(_ sender: Any) {
    
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "maintenanceNavigation")
        self.present(destination!, animated: true, completion: nil)
        
    }
    
    @IBAction func onOpenPaymentsClick(_ sender: Any) {
        
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "PaymentsNavigation")
        self.present(destination!, animated: true, completion: nil)
    }
    
    @IBAction func onMultimediOpenClick(_ sender: Any) {
        
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "multimediaId")
        self.present(destination!, animated: true, completion: nil)
        
    }
    
    func initViews(){
    
        self.navigationItem.title = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.NombreEdificio)
        
        DesignUtils.drawWhiteBorder(view: paysTicket)
        DesignUtils.drawWhiteBorder(view: paysView)
        DesignUtils.drawWhiteBorder(view: multimediaView)
        DesignUtils.drawWhiteBorder(view: maintenainceView)
        
        let url = URL(string: Urls.API_FBMTY + (MenuViewController.holdingResponse?.Picture?.comercialImages[0].Path)!)
    
        let resource = ImageResource(downloadURL: url!)
        
        let imagePlaceHolder = UIImage(named: "img_menu_back")
        if let imgView = background{
            imgView.kf.indicatorType = .activity
            imgView.kf.base.clipsToBounds = true
            imgView.kf.setImage(with: resource)
            imgView.kf.setImage(with: resource, placeholder: imagePlaceHolder, options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: nil)
        }
    }
    
    func initView(idView:String){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: idView)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
      
    
}
