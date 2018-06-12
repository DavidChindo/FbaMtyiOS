//
//  PaymentsViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner

class PaymentsViewController: BaseViewController,PaymentsDelegate,UIPickerViewDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var datesPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusSwitch: UISegmentedControl!
    @IBOutlet weak var dateLbl: UILabel!
    
    var paymentsDataSource: PaymentsDataSource?
    var paymentsPresenter: PaymentsPresenter?
    
    var mPayments:[Payments] = []
    var datesFiltes:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.navigationItem.title = "Consulta de pagos"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()

    }

    func initViews(){
        paymentsPresenter = PaymentsPresenter(delegate: self)
        setupPresenter(paymentsPresenter!)
        DesignUtils.containerRound(content: containerView)
        SwiftSpinner.show("Cargando...")
        paymentsPresenter?.payments(idHolding: (MenuViewController.holdingResponse?.Id)!)
        
        dateLbl.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:)))
        dateLbl.addGestureRecognizer(tapGesture)
        
        hideKeyboard()
    }
    
    @IBAction func onSelectedStatus(_ sender: Any) {
        
    }

    func onPaymentsSuccess(payments: [Payments], isFilter: Bool) {
        
        if !isFilter{
            
            datesFiltes = RealmManager.listUnique()
            datesPicker.delegate = self
        }
        
        mPayments = payments
        paymentsDataSource = PaymentsDataSource(tableView: tableView, items: mPayments, delegate: self)
        
        tableView?.delegate = paymentsDataSource
        tableView.dataSource = paymentsDataSource
        
        SwiftSpinner.hide()
    }
    
    func onPaymentsError(msg: String?) {
        paymentsDataSource = PaymentsDataSource(tableView: tableView, items: mPayments, delegate: self)
        SwiftSpinner.hide()
    }
    
    func onOpenPayments(payment: Payments) {
        
    }
    
    func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        datesPicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datesFiltes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datesFiltes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateLbl.text = datesFiltes[row]
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(hidePicker))
        
        view.addGestureRecognizer(tap)
    }

    func hidePicker(){
        datesPicker.isHidden = true
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
extension Array where Element : Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
}
