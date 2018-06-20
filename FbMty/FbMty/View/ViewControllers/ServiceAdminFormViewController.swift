//
//  ServiceAdminFormViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/19/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SlidingContainerViewController

class ServiceAdminFormViewController: BaseViewController {
    
    @IBOutlet weak var containerViews: UIView!

    var slidingContainerViewController:SlidingContainerViewController?    
    static var serviceAdmin: Service?
    static var idService:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconBack") , style: .plain, target: self, action: #selector(dissmissView(_:)))
        setupTabBar()
    }

    func setupTabBar(){
        let parkingsRequest = self.storyboard?.instantiateViewController(withIdentifier: "ParkingsRequestID") as! ParkingsRequestViewController
        parkingsRequest.idService = ServiceAdminFormViewController.idService
        parkingsRequest.serviceRequestAdmin = ServiceAdminFormViewController.serviceAdmin
        let parkingsInbox = self.storyboard?.instantiateViewController(withIdentifier: "ParkingsInboxID") as! ParkingsInboxViewController
        parkingsInbox.idService = ServiceAdminFormViewController.idService
        parkingsInbox.serviceInboxAdmin = ServiceAdminFormViewController.serviceAdmin
        slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [parkingsRequest, parkingsInbox],
            titles: ["SOLICITUD", "BANDEJA"])
        slidingContainerViewController?.automaticallyAdjustsScrollViewInsets = false
        
        slidingContainerViewController?.contentScrollView.frame.origin.y = (slidingContainerViewController?.sliderView.frame.origin.y)! + (slidingContainerViewController?.sliderView.frame.height)!
        slidingContainerViewController?.sliderView.appearance.backgroundColor = UIColor.white
        slidingContainerViewController?.sliderView.appearance.selectorColor = DesignUtils.darkPrimary
        slidingContainerViewController?.sliderView.appearance.textColor = UIColor.gray
        slidingContainerViewController?.sliderView.appearance.selectedTextColor = DesignUtils.darkPrimary
        slidingContainerViewController?.sliderView.appearance.selectorHeight = CGFloat(1)
        slidingContainerViewController?.sliderView.selectItemAtIndex(0)
        slidingContainerViewController?.sliderView.selectItemAtIndex(1)
        slidingContainerViewController?.sliderView.selectItemAtIndex(0)
        
        containerViews.addSubview((slidingContainerViewController?.view)!)
    }
    
    func dissmissView(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}
