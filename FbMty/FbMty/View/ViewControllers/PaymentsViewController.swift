//
//  PaymentsViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
import STPopup

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
    var status:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.navigationItem.title = "Consulta de pagos"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icDots") , style: .plain, target: self, action: #selector(showBar))
        
        
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
        
        paymentsDataSource = PaymentsDataSource(tableView: tableView, items: mPayments, delegate: self)
        
        tableView?.delegate = paymentsDataSource
        tableView.dataSource = paymentsDataSource
        
        addBtn()
        
        hideKeyboard()
    }
    
    func addBtn(){
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: view.bounds.maxX - 50, y: view.bounds.maxY - 50, width: 48, height: 38)
        button.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
        button.backgroundColor = DesignUtils.primaryDark
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = button.frame.width / 2
        button.clipsToBounds = true
        let image: UIImage = UIImage(named: "icChat")!
        button.setImage(image, for: UIControlState.normal)
        button.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
        self.view.addSubview(button)

    }
    
    func thumbsUpButtonPressed() {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ChatNavigation")
        self.present(destination!, animated: true, completion: nil)
    }
    
    @IBAction func onSearchPaymentsClick(_ sender: Any) {
        
        if !LogicUtils.validateString(word: dateLbl.text!) || (dateLbl.text?.isEmpty)!  {
            DesignUtils.messageError(vc: self, title: "Validación", msg: "Es necesario seleccionar la fecha")
        }else{
            if !LogicUtils.validateString(word: status) || (status?.isEmpty)! {
                DesignUtils.messageError(vc: self, title: "Validación", msg: "Es necesario seleccionar el estatus de pago")
            }else {
                SwiftSpinner.show("Consultando...")
                paymentsPresenter?.paymentsFilter(dateString: dateLbl.text!, payment: status!)
            }
        }
    }
    
    @IBAction func onsSelectStatus(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            status = "Pagada"
        }else{
            status = "No pagada"
        }
    }

    func onPaymentsSuccess(payments: [Payments], isFilter: Bool) {
        
        if !isFilter{
            
            datesFiltes = RealmManager.listUnique()
            datesFiltes = removeDuplicates(array: datesFiltes)
            datesPicker.delegate = self
        }
        
        mPayments = payments
        
        paymentsDataSource?.update(mPayments)
        
        SwiftSpinner.hide()
    }
    
    func onPaymentsError(msg: String?) {
        paymentsDataSource = PaymentsDataSource(tableView: tableView, items: mPayments, delegate: self)
        SwiftSpinner.hide()
    }
    
    func onOpenPayments(payment: Payments) {
        
        let viewController = storyboard!.instantiateViewController(withIdentifier: "PaymentsDetaiID") as! PaymentsDetailViewController
        viewController.payment = payment
        viewController.title  = LogicUtils.validateStringByString(word: payment.documentNumber)
        
        let popup : STPopupController = STPopupController(rootViewController: viewController)
        popup.containerView.layer.cornerRadius = 4
        popup.style = STPopupStyle.formSheet
        popup.navigationBar.barTintColor = DesignUtils.primaryDark
        popup.navigationBar.backgroundColor = DesignUtils.primaryDark
        popup.navigationBar.tintColor = UIColor.white
        
        popup.present(in: self)
        
    }
    
    func showBar(){
        let path: String = "http://fibramty.hics.mx/HoldingMediaPath/"+(MenuViewController.holdingResponse?.Id.description)!+"/FormatoPago.pdf"
         loadUrlInWebView(urlTemp: path)
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

    
    func loadUrlInWebView(urlTemp:String){
        let url = URL(string: urlTemp)

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
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
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
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
