//
//  CharacteristicsViewController.swift
//  FbMty
//
//  Created by David Barrera on 1/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class CharacteristicsViewController: BaseViewController {
    
    @IBOutlet weak var birthCont: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var phoneAdmon: UILabel!
    @IBOutlet weak var emailAdmon: UILabel!
    @IBOutlet weak var nameAdmon: UILabel!
    @IBOutlet weak var parkingsBoxes: UILabel!
    @IBOutlet weak var totalArea: UILabel!
    @IBOutlet weak var architect: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 750)
        containerView.frame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y, width: containerView.frame.width, height: 750)

        setFields()
    }
    
    func setFields(){
        
        
        
        if LogicUtils.isObjectNotNil(object: MenuViewController.holdingResponse) {
            
            birthCont.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.AniosContruccion.description)
            architect.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Arquitecto)
            totalArea.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.AreaTotal)
            parkingsBoxes.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Estacionamientos.description)
            nameAdmon.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.administrador)
            emailAdmon.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.AdministradorMail)
            phoneAdmon.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.AdministradorNumero)
        }
    
    }

}
