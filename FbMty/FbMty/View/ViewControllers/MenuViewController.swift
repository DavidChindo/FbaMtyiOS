//
//  MenuViewController.swift
//  FbMty
//
//  Created by David Barrera on 12/11/17.
//  Copyright © 2017 HICS SA DE CV. All rights reserved.
//

import UIKit
import Kingfisher
class MenuViewController: BaseViewController {

    @IBOutlet weak var background: UIImageView!

    static var holdingResponses:[HoldingResponse] = []
    static var holdingResponse:HoldingResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    @IBAction func onOpenPaymentsClick(_ sender: Any) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "PaymentsNavigation")
        self.present(destination!, animated: true, completion: nil)
    }
    
    func initViews(){
    
        self.navigationItem.title = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.NombreEdificio)
        
        let url = URL(string: Urls.API_FBMTY + (MenuViewController.holdingResponse?.Picture?.comercialImages[0].Path)!)
    
        let resource = ImageResource(downloadURL: url!)
        
        let imagePlaceHolder = UIImage(named: "img_menu_back")
        if let imgView = background{
            imgView.kf.indicatorType = .activity
            imgView.kf.base.clipsToBounds = true
            imgView.kf.setImage(with: resource)
            imgView.kf.setImage(with: resource, placeholder: imagePlaceHolder, options: [.transition(.fade(0.2))], progressBlock: nil, completionHandler: nil)
        }
    }
}
