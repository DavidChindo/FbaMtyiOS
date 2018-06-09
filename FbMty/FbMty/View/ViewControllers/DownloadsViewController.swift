//
//  DownloadsViewController.swift
//  FbMty
//
//  Created by David Barrera on 1/28/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class DownloadsViewController: BaseViewController,DownloadDelegate {

    @IBOutlet weak var lblNotData: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblArchitect: UILabel!
    @IBOutlet weak var doctosTable: UITableView!
    @IBOutlet weak var imgArchitect: UIImageView!
    
    var webView:UIWebView?
    
    var doctosDataSource:DownloadsDataSource?
    
    var emptyMessage = "No hay documentos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    
    }

    func initViews(){
        
        if LogicUtils.isObjectNotNil(object: MenuViewController.holdingResponse){
        
            if (MenuViewController.holdingResponse?.architecturalPreview?.isEmpty)!{
                
                    lblArchitect.isHidden = true
                    imgArchitect.isHidden = true
            }
            
            if (MenuViewController.holdingResponse?.OtrosList.count)! > 0 {
                
                if lblArchitect.isHidden{
                    doctosTable.frame.origin.y = lblArchitect.frame.origin.y
                }
                    
                
                doctosDataSource = DownloadsDataSource(tableView: doctosTable, items: (MenuViewController.holdingResponse?.OtrosList)!, delegate: self)
                
                doctosTable.dataSource = doctosDataSource
                doctosTable.delegate = doctosDataSource
                
                webView = UIWebView(frame: CGRect(x: scrollView.frame.origin.x, y: scrollView.frame.origin.y, width: scrollView.frame.width, height: scrollView.frame.height))
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar", style: .plain, target: self, action: #selector(closeWebView))
                webView?.isHidden = true
                self.view.addSubview(webView!)
                isShowingWebView()
                
            }else{
            
                doctosTable.isHidden = true
                
            }
        
            if lblArchitect.isHidden && doctosTable.isHidden{
                lblNotData.isHidden = false
            }
        }

    }
    
    func onOpenDocto(path: String) {
        loadUrlInWebView(url: path)
    }
    
    
    func closeWebView(){
        webView?.stopLoading()
        webView?.goBack()
        webView?.isHidden = true
        
        isShowingWebView()
    }
    
    func isShowingWebView(){
        if (webView?.isHidden)!{
            navigationItem.rightBarButtonItem?.title = ""
            navigationItem.rightBarButtonItem?.isEnabled = false
        }else{
            navigationItem.rightBarButtonItem?.title = "Cerrar"
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func loadUrlInWebView(url:String){
        var urlTemp: String = url.contains(" ") ? url.replacingOccurrences(of: " ", with: "%20") : url
        let url_request_temp = URL(string: urlTemp)
        let url_request = URLRequest(url: url_request_temp!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 1.0)
        webView?.loadRequest(url_request)
        webView?.isHidden = false
        isShowingWebView()
    }
}
