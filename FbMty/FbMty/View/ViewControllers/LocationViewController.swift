//
//  LocationViewController.swift
//  FbMty
//
//  Created by David Barrera on 1/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationViewController: BaseViewController {

    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressContainer: UIView!
    @IBOutlet weak var majorContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerMap: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: (MenuViewController.holdingResponse?.Coordinates?.latitude)!, longitude: (MenuViewController.holdingResponse?.Coordinates?.longitude)!, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.NombreEdificio)
        
        marker.map = mapView
        
        self.view = mapView
        
        self.view.addSubview(containerMap)
        
        initViews()

        
    }

    func initViews(){
        
        if LogicUtils.isObjectNotNil(object:  MenuViewController.holdingResponse){
            DesignUtils.containerRound(content: containerMap)
            nameLbl.text = MenuViewController.holdingResponse?.NombreEdificio!
            if LogicUtils.isObjectNotNil(object: MenuViewController.holdingResponse?.Address){
                addressLbl.text = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Address?.street)+" "+LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Address?.numberExt)+" "+LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Address?.suburb)+" "+LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Address?.town)+" "+LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Address?.zip)+" "+LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.Address?.state)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let camera = GMSCameraPosition.camera(withLatitude: (MenuViewController.holdingResponse?.Coordinates?.latitude)!, longitude: (MenuViewController.holdingResponse?.Coordinates?.longitude)!, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = LogicUtils.validateStringByString(word: MenuViewController.holdingResponse?.NombreEdificio)
        
        marker.map = mapView
        
        self.view = mapView
        
        self.view.addSubview(containerMap)
        
        initViews()
    }
}
