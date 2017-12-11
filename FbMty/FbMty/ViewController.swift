//
//  ViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/1/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import CTPanoramaView

class ViewController: BaseViewController {
    @IBOutlet weak var pv: CTPanoramaView!
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var window:UIWindow?

    @IBOutlet weak var compassView: CTPieSliceView!


    override func viewDidLoad() {
        super.viewDidLoad()
        customViews()
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        initView(idView: "menuVC")
    }
    
    @IBAction func panoramaTypeTapped() {
        if pv.panoramaType == .spherical {
            let image = UIImage(named: "back.jpg")
            pv.image = image
        }
        else {
            let image = UIImage(named: "back.jpg")
            pv.image = image
        }
    }
    
    @IBAction func motionTypeTapped() {
        if pv.controlMethod == .touch {
            pv.controlMethod = .motion
        }
        else {
            pv.controlMethod = .touch
        }
    }
    
    func customViews(){
        let image = UIImage(named: "back.jpg")
        pv.image = image
        pv.compass = compassView
    }

    //        initView(idView: "ChooseCompanyID")

    func initView(idView:String){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: idView)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
}

