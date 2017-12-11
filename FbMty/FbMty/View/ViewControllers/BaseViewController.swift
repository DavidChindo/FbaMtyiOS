//
//  BaseViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var basePresenter:BasePresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.basePresenter?.loadPresenter()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.basePresenter?.unloadPresenter()
    }
    
    func setupPresenter<T: BasePresenter>(_ basePresenter:T ){
        self.basePresenter = basePresenter
    }
    

}
