//
//  ObjectViewController.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/05/24.
//

import UIKit
import WebKit
import Firebase

class ObjectViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {

    var HybridWeb = WKWebView()
    var Event_name = String()
    
    override func loadView() {
        super.loadView()
        let webconfig = WKWebViewConfiguration()
        let webcontent = WKUserContentController()
        
        webcontent.add(self, name: "gascriptCallbackHandler")
        webconfig.userContentController = webcontent
        
        webconfig.applicationNameForUserAgent = "/GA_iOS_WK"
        HybridWeb = WKWebView.init(frame: self.view.frame, configuration: webconfig)
        HybridWeb.uiDelegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.navigationController?.isNavigationBarHidden = false

        let request_url = URLRequest(url: URL(string: "http://210.114.9.23/GA_part/ga_jylee/bootstrap/index_DJKIM.html")!)
        HybridWeb.load(request_url)
        view.addSubview(self.HybridWeb)
    }
    

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage){
        if message.name == "gascriptCallbackHandler" {
            do{
                let TEST = GA.init()
                try TEST.hybirddata(message: message)
            }catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        
    }
}
