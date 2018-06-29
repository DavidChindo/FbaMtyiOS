//
//  MenuTabViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/11/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class MenuTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }


}
