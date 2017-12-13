//
//  MenuViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onOpenPaymentsClick(_ sender: Any) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "PaymentsNavigation")
        self.present(destination!, animated: true, completion: nil)
    }
    
}
