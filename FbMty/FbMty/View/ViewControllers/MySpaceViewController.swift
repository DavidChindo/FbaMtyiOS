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
import ImageSlideshow

class MySpaceViewController: BaseViewController{

    @IBOutlet weak var portalImage: UIImageView!
    @IBOutlet var slideshow: ImageSlideshow!
    @IBOutlet weak var containerView: UIView!
    
    var slidingContainerViewController:SlidingContainerViewController?
    var frameContentScrollView: CGRect!
    var frameSliderView: CGRect!
    var countFrame = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //    setupTabBar()
         //   initImages()
        
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
        
        /*slidingContainerViewController?.contentScrollView.frame.origin.y = (slidingContainerViewController?.sliderView.frame.origin.y)! + (slidingContainerViewController?.sliderView.frame.height)!*/
        
        slidingContainerViewController?.sliderView.appearance.backgroundColor = UIColor.white
        slidingContainerViewController?.sliderView.appearance.selectorColor = DesignUtils.darkPrimary
        slidingContainerViewController?.sliderView.appearance.textColor = UIColor.gray
        slidingContainerViewController?.sliderView.appearance.selectedTextColor = DesignUtils.darkPrimary
        slidingContainerViewController?.sliderView.appearance.selectorHeight = CGFloat(1)
        slidingContainerViewController?.sliderView.selectItemAtIndex(0)
    
        if countFrame == 0 {
            frameContentScrollView = slidingContainerViewController?.contentScrollView.frame
            frameSliderView = slidingContainerViewController?.sliderView.frame
            countFrame += 1
        }
        
        slidingContainerViewController?.sliderView.frame = frameSliderView
        slidingContainerViewController?.contentScrollView.frame = frameContentScrollView
        
        containerView.addSubview((slidingContainerViewController?.view)!)
        
        
}

    override func viewWillAppear(_ animated: Bool) {
        setupTabBar()
        initImages()
    }
    
    func initImages(){
        slideshow.slideshowInterval = 5.0
        
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        
        var kingfisherSource:[KingfisherSource] = []
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        slideshow.activityIndicator = DefaultActivityIndicator()
  
        for path in (MenuViewController.holdingResponse?.Picture?.detalleImages)! {
            let longPath = Urls.API_FBMTY + path.Path!
            kingfisherSource.append(KingfisherSource(urlString: longPath)!)
        }
        
     slideshow.setImageInputs(kingfisherSource)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        slidingContainerViewController?.view.removeFromSuperview()
        
    }
    

}
