//
//  SceneDelegate.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/02/23.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        window?.rootViewController = UINavigationController(rootViewController: ViewController())
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()

        //전자상거래 관련 코드
        let product1 = NSMutableDictionary.init()
        let action = NSMutableDictionary.init()
        let detail = NSMutableDictionary.init()
        let add = NSMutableDictionary.init()
        let remove = NSMutableDictionary.init()
        let checkout1 = NSMutableDictionary.init()
        let checkout2 = NSMutableDictionary.init()
        let purchase = NSMutableDictionary.init()
        let refund = NSMutableDictionary.init()
        
        product1.setValue("10/07_08:07", forKey: AnalyticsParameterItemID)
        product1.setValue("10/07_08:071짱", forKey: AnalyticsParameterItemName)
        //상품에 디멘션 담으면 전송가능함 개쩐다;;
        product1.setValue("ProductDimension12", forKey: "dimension12")
        product1.setValue(3000, forKey: "metric3")
        product1.setValue("10/07_08:07Men/TEST_ios", forKey: AnalyticsParameterItemCategory)
        product1.setValue("10/07_08:07_BLueMall", forKey: AnalyticsParameterItemVariant)
        product1.setValue("10/07_08:07_Goldenplanet", forKey: AnalyticsParameterItemBrand)
        product1.setValue(1002333, forKey: AnalyticsParameterPrice)
        product1.setValue("KRW", forKey: AnalyticsParameterCurrency)
        product1.setValue(1, forKey: AnalyticsParameterIndex)
        product1.setValue(1, forKey: AnalyticsParameterQuantity)
        let items = NSMutableArray.init()
        items.addObjects(from: [product1])
        
        action.setValue(items, forKey: AnalyticsParameterItems)
        detail.setValue(items, forKey: AnalyticsParameterItems)
        add.setValue(items, forKey: AnalyticsParameterItems)
        remove.setValue(items, forKey: AnalyticsParameterItems)
        checkout1.setValue(items, forKey: AnalyticsParameterItems)
        checkout2.setValue(items, forKey: AnalyticsParameterItems)
        purchase.setValue(items, forKey: AnalyticsParameterItems)
        refund.setValue(items, forKey: AnalyticsParameterItems)
        
        
        action.setValue("운영", forKey: "version")
        detail.setValue("운영", forKey: "version")
        add.setValue("운영", forKey: "version")
        remove.setValue("운영", forKey: "version")
        checkout1.setValue("운영", forKey: "version")
        checkout2.setValue("운영", forKey: "version")
        purchase.setValue("운영", forKey: "version")
        refund.setValue("운영", forKey: "version")
        
        //클릭
        action.setValue("10/07_08:07_GTM SDK 개쓰레기", forKey: AnalyticsParameterItemList)
        
        //체크아웃1,2
        checkout1.setValue(1, forKey: AnalyticsParameterCheckoutStep)
        checkout1.setValue("10/07_08:07_visacard", forKey: AnalyticsParameterCheckoutOption)
        checkout2.setValue(2, forKey: AnalyticsParameterCheckoutStep)
        checkout2.setValue("10/07_08:07_visacard_2", forKey: AnalyticsParameterCheckoutOption)
        
        //구매
        purchase.setValue("10/07_08:07_GTM SDK 개쓰레기", forKey: AnalyticsParameterItemList)
        purchase.setValue("10/07_08:07_DJKIM_TID", forKey: AnalyticsParameterTransactionID)
        purchase.setValue("10/07_08:07_affiliation", forKey: AnalyticsParameterAffiliation)
        purchase.setValue(10000000, forKey: AnalyticsParameterValue)
        purchase.setValue(100, forKey: AnalyticsParameterTax)
        purchase.setValue(5000000, forKey: AnalyticsParameterShipping)
        purchase.setValue("KRW", forKey: AnalyticsParameterCurrency)
        
        
        //환불
        refund.setValue("10/07_08:07_DJKIM_TID", forKey: AnalyticsParameterTransactionID)
        refund.setValue(10000000, forKey: AnalyticsParameterValue)
        
        
        action.setValue("전자상거래클릭_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        detail.setValue("전자상거래디테일_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        add.setValue("전자상거래장바구니_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        remove.setValue("전자상거래장바구니제거_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        checkout1.setValue("전자상거래체크아웃1_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        checkout2.setValue("전자상거래체크아웃2_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        purchase.setValue("전자상거래구매_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        refund.setValue("전자상거래환불_진짜마지막이다", forKey: AnalyticsParameterScreenName)
        
        
        
        action.setValue("Ecommerce", forKey: "category")
        action.setValue("Click", forKey: "action")
        
        detail.setValue("Ecommerce", forKey: "category")
        detail.setValue("Detail", forKey: "action")
        
        add.setValue("Ecommerce", forKey: "category")
        add.setValue("add", forKey: "action")
        
        remove.setValue("Ecommerce", forKey: "category")
        remove.setValue("remove", forKey: "action")
        
        checkout1.setValue("Ecommerce", forKey: "category")
        checkout1.setValue("checkout", forKey: "action")
        
        checkout2.setValue("Ecommerce", forKey: "category")
        checkout2.setValue("checkout", forKey: "action")
        
        purchase.setValue("Ecommerce", forKey: "category")
        purchase.setValue("purchase", forKey: "action")
        
        refund.setValue("Ecommerce", forKey: "category")
        refund.setValue("refund", forKey: "action")
        
        //GA4에만 적재
//        Analytics.logEvent(AnalyticsEventSelectItem, parameters: (action as! [String : Any]))
//
//        //GA360에만 적재
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: (action as! [String : Any]))
//        
//        
//        Analytics.logEvent(AnalyticsEventViewItem, parameters: (detail as! [String : Any]))
//        Analytics.logEvent(AnalyticsEventAddToCart, parameters: (add as! [String : Any]))
//        Analytics.logEvent(AnalyticsEventRemoveFromCart, parameters: (remove as! [String : Any]))
//        Analytics.logEvent(AnalyticsEventBeginCheckout, parameters: (checkout1 as! [String : Any]))
//        
//        //GA360에만 적재 - 체크아웃
//        Analytics.logEvent(AnalyticsEventCheckoutProgress, parameters: (checkout2 as! [String : Any]))
//        
//        //GA4에만 적재 - 체크아웃
//        Analytics.logEvent(AnalyticsEventAddPaymentInfo, parameters: (checkout2 as! [String : Any]))
//        Analytics.logEvent(AnalyticsEventAddShippingInfo, parameters: (checkout2 as! [String : Any]))
//        
//        //GA360에만 적재 - 구매
//        Analytics.logEvent(AnalyticsEventEcommercePurchase, parameters: (purchase as! [String : Any]))
//        
//        //GA4에만 적재 - 구매
//        Analytics.logEvent(AnalyticsEventPurchase, parameters: (purchase as! [String : Any]))
//        
//        //GA360에만 적재 - 환불
//        Analytics.logEvent(AnalyticsEventPurchaseRefund, parameters: (refund as! [String : Any]))
//        //GA4에만 적재 - 환불, currencycode와 같이 유효하지 않은 데이터 에러 발생
//        Analytics.logEvent(AnalyticsEventRefund, parameters: (refund as! [String : Any]))
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        var OPENURL = URLContexts.first!.url
        splitQuery(url: OPENURL)
    }
    
    func splitQuery(url : URL){
        let campaignDictionary = NSMutableDictionary()
        let Query_url = url.absoluteString
        let Query_U = Query_url.removingPercentEncoding
        let Query_spilt_1 = Query_U!.components(separatedBy: "//?")
        let Query_spilt_2 = Query_spilt_1[1]
        let Query_spilt = Query_spilt_2.components(separatedBy: "&")
            campaignDictionary.setValue("캠페인>딥링크_찐막", forKey: AnalyticsParameterScreenName)
     
            for i in 0..<Query_spilt.count{
                let Campaign_Value = (Query_spilt[i]).components(separatedBy: "=")
                if Query_spilt[i].contains("utm_source"){ campaignDictionary.setValue(Campaign_Value[1], forKey: AnalyticsParameterSource) }
                if Query_spilt[i].contains("utm_medium"){ campaignDictionary.setValue(Campaign_Value[1], forKey: AnalyticsParameterMedium) }
                if Query_spilt[i].contains("utm_term"){ campaignDictionary.setValue(Campaign_Value[1], forKey: AnalyticsParameterTerm) }
                if Query_spilt[i].contains("utm_content"){ campaignDictionary.setValue(Campaign_Value[1], forKey: AnalyticsParameterContent) }
                if Query_spilt[i].contains("utm_campaign"){ campaignDictionary.setValue(Campaign_Value[1], forKey: AnalyticsParameterCampaign) }
            }
        GA.init().GADataSend(type: "campaign", Data: campaignDictionary)

    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

