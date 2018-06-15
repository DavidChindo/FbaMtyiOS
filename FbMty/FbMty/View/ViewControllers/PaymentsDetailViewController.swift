//
//  PaymentsDetailViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/14/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import STPopup

class PaymentsDetailViewController: BaseViewController {

    @IBOutlet weak var containerStatus: UIView!
    @IBOutlet weak var explanationTxtView: UITextView!
    @IBOutlet weak var documentType: UILabel!
    @IBOutlet weak var amountwordLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var dateAccounting: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var containerViews: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var payment:Payments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.backgroundColor = DesignUtils.primaryDark
        
        self.contentSizeInPopup = CGSize(width: 300, height: 470)
        self.landscapeContentSizeInPopup = CGSize(width: 300, height: 150)
        
        initViews()
    }
    
    
    func initViews(){
        
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 750)
        containerViews.frame = CGRect(x: containerViews.frame.origin.x, y: containerViews.frame.origin.y, width: containerViews.frame.width, height: 750)
        
        if LogicUtils.isObjectNotNil(object: payment){
            
            statusLbl.text = LogicUtils.validateStringByString(word: payment?.status)
            dateAccounting.text = LogicUtils.validateStringByString(word: payment?.dateValidity)
            amountLbl.text = LogicUtils.validateStringByString(word: payment?.amount)
            amountwordLbl.text = LogicUtils.validateStringByString(word: payment?.currency)
            documentType.text = LogicUtils.validateStringByString(word: payment?.name)
            explanationTxtView.text = LogicUtils.validateStringByString(word: payment?.descriptionPay)
            DesignUtils.setFillView(view: containerStatus, background: colorStatus(status: payment?.status))
            explanationTxtView.sizeToFit()
            var frame = explanationTxtView.frame
            frame.size.height = explanationTxtView.contentSize.height
            explanationTxtView.frame = frame
            
            containerViews.frame = CGRect(x: containerViews.frame.origin.x, y: containerViews.frame.origin.y, width: containerViews.frame.width, height: (explanationTxtView.frame.origin.y + explanationTxtView.frame.height + 20))
            scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: (explanationTxtView.frame.origin.y + explanationTxtView.frame.height + 20))
            
        }
    }
    
    func colorStatus(status:String?) ->UIColor{
        return status?.lowercased() == "pagada" ? DesignUtils.greenStatus : DesignUtils.redBio
    }
}
