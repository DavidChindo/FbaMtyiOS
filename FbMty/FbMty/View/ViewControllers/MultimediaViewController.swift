//
//  MultimediaViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/11/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
class MultimediaViewController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
/*
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        */
        webView.delegate = self
        
        let button = UIButton(type: .system)

        self.webView.allowsInlineMediaPlayback = true
        SwiftSpinner.show("Cargando...")
        
        /*
        let embededHTML = "<div style=\"width: 100%\"><iframe src=\"https://player.vimeo.com/video/"+idVideo[(idVideo.count-1)]+"?autoplay=1&byline=0&portrait=0\"\" style=\"position:fixed;top:0;left:0;  width:100%;height:100%;\" frameborder=\"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe></div><script src=\"https://player.vimeo.com/api/player.js\"></script>";
        */
        
        //self.webView.loadHTMLString(embededHTML, baseURL: Bundle.main.bundleURL) idVideo[idVideo.count-1]
        let id = "11"
        //loadUrlInWebView(url: )

        
        
        button.frame = CGRect(x: view.bounds.maxX - 60, y: 16, width: 48, height: 38)
        button.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
        button.setTitle("Cerrar", for: UIControlState.normal)
        button.backgroundColor = DesignUtils.primaryDark
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(MultimediaViewController.onCloseClick), for: .touchUpInside)
        webView.insertSubview(button, aboveSubview: webView)
        
        }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SwiftSpinner.hide()
    }
    
   /* override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .landscapeRight
        }
    }*/
    
    func loadUrlInWebView(url:String){
        var urlTemp: String = url.contains(" ") ? url.replacingOccurrences(of: " ", with: "%20") : url
        let url_request_temp = URL(string: urlTemp)
        //let url_request = URLRequest(url: url_request_temp!)
        let url_request = URLRequest(url: url_request_temp!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 1.0)
        webView?.loadRequest(url_request)
        webView?.isHidden = false
    }
    
    func onCloseClick() {
        webView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
}
