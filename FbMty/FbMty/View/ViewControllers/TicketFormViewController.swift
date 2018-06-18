//
//  TicketFormViewController.swift
//  FbMty
//
//  Created by David Barrera on 6/17/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit
import SwiftSpinner
import STPopup
import MobileCoreServices
import Zip

class TicketFormViewController: BaseViewController,TicketDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var fileNmeLbl: UILabel!
    @IBOutlet weak var explanationTxtView: UITextView!
    
    var ticketPresenter: TicketPresenter?
    var ticketService: Service?
    
    var files:[String] = []
    var filesPath:[URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = DesignUtils.colorPrimary
        
        self.contentSizeInPopup = CGSize(width: 300, height: 370)
        self.landscapeContentSizeInPopup = CGSize(width: 300, height: 150)
        
        initViews()
        
    }
    
    func initViews(){
        ticketPresenter = TicketPresenter(delegate: self)
        setupPresenter(ticketPresenter!)
    }

    @IBAction func sendFileClick(_ sender: Any) {
        do {
            let zipFilePath = try Zip.quickZipFiles(filesPath, fileName: fileNmeLbl.text!)
            guard let data = NSData(contentsOf: zipFilePath ) else {
                return
            }
            let sizeVideo = Double(data.length / 1048576)
            print("zipFileLenght: \(sizeVideo)")
            print("ZIPFILEPATH: \(zipFilePath)")
            SwiftSpinner.sharedInstance.titleLabel.text = "Subiendo..."
            let descriptionS = LogicUtils.validateStringByString(word: explanationTxtView.text!)
        ticketPresenter?.uploadTicket(urlZip: zipFilePath, descriptionS: descriptionS, serviceId: (ticketService?.id.description)!, holdingId: (MenuViewController.holdingResponse?.Id.description)!)
        }
        catch let error{
            SwiftSpinner.hide()
            print(error.localizedDescription)
            print("Something went wrong")
            DesignUtils.alertConfirm(titleMessage: "Atención", message: "Por el momento no es posible generar el empaquetado de archivos.", vc: self)
        }
        
    }
    
    @IBAction func addFileClick(_ sender: Any) {
        openExplorer()
    }
    
    func onSentTicketSuccess(msg: String?) {
    
    }
    
    func onSentTicketError(msg: String?) {
        
    }
    
    func openExplorer(){
        let importMenu = UIDocumentMenuViewController(documentTypes:["public.image","public.movie","public.item","public.content","public.composite-content","public.archive"], in: .import)
        /*[String(kUTTypeText),String(kUTTypeImage),String(kUTTypeItem)] */
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        self.present(importMenu, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *)
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let path = url as URL
        do {
            let pathtemp = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let documentDirectory = URL(fileURLWithPath: pathtemp)
            let pathsepate:[String] = path.absoluteString.components(separatedBy: "/")
            let destinationPath = documentDirectory.appendingPathComponent(pathsepate[pathsepate.count - 1])
            
            if (FileManager.default.fileExists(atPath: destinationPath.path)){
                print("Exits")
                do {
                    try FileManager.default.removeItem(atPath: destinationPath.path)
                    print("Removal successful")
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                }
            }else{
                print("Not Exits")
            }
            try FileManager.default.moveItem(at: url, to: destinationPath)
            print(destinationPath)
            print("The Url is : \(path)")
            files.append(path.absoluteString)
            filesPath.append(destinationPath)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @available(iOS 8.0, *)
    public func documentMenu(_ documentMenu:  UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("we cancelled")
        dismiss(animated: true, completion: nil)
    }
    


}
