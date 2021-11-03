//
//  WeeKStepViewController.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/22.
//

import UIKit
import WebKit
import HealthKit
class WeeKStepViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler{
    
    var WeekView = WKWebView()
    
    override func loadView() {
        super.loadView()
        let webconfig = WKWebViewConfiguration()
        let webcontent = WKUserContentController()
        
        webcontent.add(self, name: "callbackHandler")
        webconfig.userContentController = webcontent
        
        webconfig.applicationNameForUserAgent = "/GA_iOS_WK"
        WeekView = WKWebView.init(frame: self.view.frame, configuration: webconfig)
        WeekView.uiDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.navigationController?.isNavigationBarHidden = false

        let request_url = URLRequest(url: URL(string: "http://210.114.9.22/GA_part/identity/tab4.html")!)
        WeekView.load(request_url)
        view.addSubview(self.WeekView)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callbackHandler" {
            let data = (message.body as AnyObject).data(using: String.Encoding.utf8.rawValue,allowLossyConversion: false)!
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let startdate = json["startdate"] as! String
                let enddate = json["enddate"] as! String
                let conver_start = Health.sharedInstace().DateFormat(convertdate: startdate + "T00:00:00")
                let conver_end = Health.sharedInstace().DateFormat(convertdate: enddate + "T23:59:59")
                
                Health.sharedInstace().WeekDate(week_start: conver_start, week_end: conver_end)
                
                
                var GG = ""
            }catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    

}
