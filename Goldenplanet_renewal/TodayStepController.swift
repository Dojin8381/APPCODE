//
//  TodayStepController.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/08.
//
// 공통부분 함수화 처리

import UIKit
import WebKit
import HealthKit
class TodayStepController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var todayWeb = WKWebView()
    override func loadView() {
        super.loadView()
        let webconfig = WKWebViewConfiguration()
        let webcontent = WKUserContentController()
        webconfig.userContentController = webcontent
        todayWeb = WKWebView.init(frame: self.view.frame, configuration: webconfig)
        todayWeb.uiDelegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "최근 걸음 수"
        loadURL()
    }

    func loadURL(){
        let request_url = URLRequest(url: URL(string: Health.sharedInstace().URLString)!)
        todayWeb.load(request_url)
        view.addSubview(self.todayWeb)
    }
}
