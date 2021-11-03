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
//        let Screen = NSMutableDictionary()
//        Screen.setValue("ABC_탭선택_구분자_다시", forKey: "category")
//        Screen.setValue("ABC_클릭", forKey: "action")
//        Screen.setValue("{{선택값}}", forKey: "label")
//        Screen.setValue("하이브리드 로드 전", forKey: AnalyticsParameterScreenName)
       
//        GA.init().GADataSend(type: "gaevent", Data: Screen)
//        GA.init().GADataSend(type: "APPWEB_event", Data: Screen)
        
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
//if json["userId"] != nil{ Analytics.setUserID((json["userId"] as! String)) }
//if json["title"] != nil {
//    GAData.setValue(AnalyticsParameterScreenName, forKey: json["title"] as! String)
//}
//if json["location"] != nil {
//    GAData.setValue(AnalyticsParameterScreenClass, forKey: json["location"] as! String)
//}
