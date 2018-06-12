//
//  MaintenanceDetailViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import STPopup

class MaintenanceDetailViewController: BaseViewController {
    
    @IBOutlet weak var contentTxtView: UITextView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var frequencyLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var nameProviderLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    var maintenanceObj: Maintenance?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentSizeInPopup = CGSize(width: 300, height: 500)
        self.landscapeContentSizeInPopup = CGSize(width: 300, height: 150)

        initViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func initViews(){
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 750)
        containerView.frame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y, width: containerView.frame.width, height: 750)

        
        if LogicUtils.isObjectNotNil(object: maintenanceObj){
            
            titleLbl.text = "  " + LogicUtils.validateStringByString(word: maintenanceObj?.title)
            frequencyLbl.text = LogicUtils.validateStringByString(word: maintenanceObj?.schedule)
            nameProviderLbl.text = LogicUtils.validateStringByString(word: maintenanceObj?.provider)
            phoneLbl.text = LogicUtils.validateStringByString(word: maintenanceObj?.ProviderPhone)
            mobileLbl.text = LogicUtils.validateStringByString(word: maintenanceObj?.ProviderCellPhone)
            emailLbl.text = LogicUtils.validateStringByString(word: maintenanceObj?.ProviderEmail)
            contentTxtView.text = LogicUtils.validateStringByString(word: maintenanceObj?.descriptionMa)
            
            contentTxtView.sizeToFit()
            var frame = contentTxtView.frame
            frame.size.height = contentTxtView.contentSize.height
            contentTxtView.frame = frame
            
            containerView.frame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y, width: containerView.frame.width, height: (contentTxtView.frame.origin.y + contentTxtView.frame.height + 20))
            scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: (contentTxtView.frame.origin.y + contentTxtView.frame.height + 20))
            
        }
    }

}
