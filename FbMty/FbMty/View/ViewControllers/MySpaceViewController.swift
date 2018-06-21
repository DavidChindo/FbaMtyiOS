//
//  MySpaceViewController.swift
//  FbMty
//
//  Created by David Barrera on 1/26/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SlidingContainerViewController
import Kingfisher

class MySpaceViewController: BaseViewController{

    @IBOutlet weak var portalImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    static var slidingParent: SlidingContainerViewController?
    
    var slidingContainerViewController:SlidingContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupTabBar()
            initImages()
    }

    func setupTabBar(){
        let characteristicsView = self.storyboard?.instantiateViewController(withIdentifier: "CharacteristicsID") as! CharacteristicsViewController
        let servicesView = self.storyboard?.instantiateViewController(withIdentifier: "ServicesID") as! ServicesViewController
        let downloadsView = self.storyboard?.instantiateViewController(withIdentifier: "DownloadsID") as! DownloadsViewController
        let locationView = self.storyboard?.instantiateViewController(withIdentifier: "locationID") as! LocationViewController
        
        slidingContainerViewController = SlidingContainerViewController (
            parent: self,
            contentViewControllers: [characteristicsView, servicesView,downloadsView,locationView],
            titles: ["CARACTERISTICAS", "SERVICIOS","DESCARGAR","UBICACIÓN"])
        slidingContainerViewController?.automaticallyAdjustsScrollViewInsets = false
        
        slidingContainerViewController?.contentScrollView.frame.origin.y = (slidingContainerViewController?.sliderView.frame.origin.y)! + (slidingContainerViewController?.sliderView.frame.height)!
        slidingContainerViewController?.sliderView.appearance.backgroundColor = UIColor.white
        slidingContainerViewController?.sliderView.appearance.selectorColor = DesignUtils.darkPrimary
        slidingContainerViewController?.sliderView.appearance.textColor = UIColor.gray
        slidingContainerViewController?.sliderView.appearance.selectedTextColor = DesignUtils.darkPrimary
        slidingContainerViewController?.sliderView.appearance.selectorHeight = CGFloat(1)
        slidingContainerViewController?.sliderView.selectItemAtIndex(0)
        
        MySpaceViewController.slidingParent = slidingContainerViewController
        containerView.addSubview((slidingContainerViewController?.view)!)
}

    override func viewWillAppear(_ animated: Bool) {
        initImages()
    }
    func initImages(){
        let url = URL(string: Urls.API_FBMTY + (MenuViewController.holdingResponse?.Picture?.comercialImages[0].Path)!)
        
        let resource = ImageResource(downloadURL: url!)
        
        let imagePlaceHolder = UIImage(named: "img_menu_back")
        if let imgView = portalImage{
            imgView.kf.indicatorType = .activity
            //imgView.kf.base.clipsToBounds = true
            //imgView.kf.setImage(with: resource)
            imgView.kf.setImage(with: resource, placeholder: imagePlaceHolder, options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: nil)
        }
    }
    
    
    

}
