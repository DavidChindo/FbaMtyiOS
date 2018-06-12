//
//  MaintenanceViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
import STPopup

class MaintenanceViewController: BaseViewController,MaintenanceDelegate {

    
    @IBOutlet weak var maintenanceTableView: UITableView!
    
    var maintenanceDataSource:MaintenanceDataSource?
    var maintenencePresenter:MaintenancePresenter?
    var mMaintenance:[Maintenance] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.navigationItem.title = "Mantenimiento"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))

    
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()

    }
    
    func initViews(){
        maintenencePresenter = MaintenancePresenter(delegate: self)
        setupPresenter(maintenencePresenter!)
        SwiftSpinner.show("Cargando...")
        maintenencePresenter?.maintenances(idHolding: (MenuViewController.holdingResponse?.Id)!)
        
        
    }
    
    func onLoadMaintenance(maintenances: [Maintenance]) {
        
        mMaintenance = maintenances
        maintenanceDataSource = MaintenanceDataSource(tableView: maintenanceTableView, items: mMaintenance, delegate: self)
        
        maintenanceTableView.dataSource = maintenanceDataSource
        maintenanceTableView.delegate = maintenanceDataSource
        
        SwiftSpinner.hide()
    }
    
    func onErrorMaintenance(msgError: String?) {
        
            SwiftSpinner.hide()
            DesignUtils.alertConfirm(titleMessage: "Mantenimiento", message: msgError!, vc: self)
        
    }
    
    func onSelectedMaintenance(maintenance: Maintenance) {
        
        let viewController = storyboard!.instantiateViewController(withIdentifier: "MaintenanceDetailID") as! MaintenanceDetailViewController
        viewController.maintenanceObj = maintenance
        viewController.title  = LogicUtils.validateStringByString(word: maintenance.title)
        
        let popup : STPopupController = STPopupController(rootViewController: viewController)
        popup.containerView.layer.cornerRadius = 4
        popup.style = STPopupStyle.formSheet
        popup.navigationBar.barTintColor = DesignUtils.primaryDark
        popup.navigationBar.backgroundColor = DesignUtils.primaryDark
        popup.navigationBar.tintColor = UIColor.white
    
        popup.present(in: self)
        
    }
    
    func dissmissView(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }


}
