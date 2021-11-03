//
//  Hybrid.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/09/06.
//  전자상거래코드 메모장에 저장

import UIKit
import WebKit
import Firebase

// MARK: 에러 변환
enum TypeError : Error {
    case invaildType
    case invaildField
    case requiredValue
}
class Errorfunction{
    class func TypeCasting(jsondata:[String: AnyObject], CheckValue:String) throws -> AnyObject{
        let Data = jsondata
        guard let _ = Data[CheckValue] else{
            throw TypeError.invaildField
        }
        return Data[CheckValue]!
    }
    
    class func ObjectTypeCasting(CheckDictionary:NSMutableDictionary) throws -> [String:AnyObject]{
        guard let Data = CheckDictionary as? [String:AnyObject] else{
            throw TypeError.invaildField
        }
        return Data
    }
}

// MARK: Hybird Data SET
class CommonData{
    public var USE_WEBDATA = NSMutableDictionary()
    public var Parameter_Data = NSMutableDictionary()
    struct  StaticInstance {
        static var instance : CommonData?
    }
    class func sharedInstace() -> CommonData{
        if(StaticInstance.instance == nil){
            StaticInstance.instance = CommonData()
        }
        return StaticInstance.instance!
    }
}



// MARK: 전자상거래 변환
class GA_Ecomerce{
    var Event_name = String()
    let Product_Convert = NSMutableDictionary.init()
    let EcommerceStep_Convert = NSMutableDictionary.init()
    let Transaction_Convert = NSMutableDictionary.init()
    
    init(){
        self.Product_Convert.setValue(AnalyticsParameterItemID, forKey: "id")
        self.Product_Convert.setValue(AnalyticsParameterItemName, forKey: "name")
        self.Product_Convert.setValue(AnalyticsParameterItemBrand, forKey: "brand")
        self.Product_Convert.setValue(AnalyticsParameterItemCategory, forKey: "category")
        self.Product_Convert.setValue(AnalyticsParameterQuantity, forKey: "quantity")
        self.Product_Convert.setValue(AnalyticsParameterItemVariant, forKey: "variant")
        self.Product_Convert.setValue(AnalyticsParameterIndex, forKey: "position")
        self.Product_Convert.setValue(AnalyticsParameterPrice, forKey: "price")
        self.Product_Convert.setValue(AnalyticsParameterCoupon, forKey: "coupon")
        
        self.EcommerceStep_Convert.setValue(AnalyticsEventViewItemList, forKey: "impressions")
        self.EcommerceStep_Convert.setValue(AnalyticsEventSelectContent, forKey: "click")
        self.EcommerceStep_Convert.setValue(AnalyticsEventViewItem, forKey: "detail")
        self.EcommerceStep_Convert.setValue(AnalyticsEventAddToCart, forKey: "add")
        self.EcommerceStep_Convert.setValue(AnalyticsEventRemoveFromCart, forKey: "remove")
        self.EcommerceStep_Convert.setValue(AnalyticsEventBeginCheckout, forKey: "checkout")
        self.EcommerceStep_Convert.setValue(AnalyticsEventEcommercePurchase, forKey: "purchase")
        self.EcommerceStep_Convert.setValue(AnalyticsEventPurchaseRefund, forKey: "refund")
        
        self.Transaction_Convert.setValue(AnalyticsParameterTransactionID, forKey: "id")
        self.Transaction_Convert.setValue(AnalyticsParameterShipping, forKey: "shipping")
        self.Transaction_Convert.setValue(AnalyticsParameterTax, forKey: "tax")
        self.Transaction_Convert.setValue(AnalyticsParameterCoupon, forKey: "coupon")
        self.Transaction_Convert.setValue(AnalyticsParameterValue, forKey: "revenue")
        self.Transaction_Convert.setValue(AnalyticsParameterAffiliation, forKey: "affiliation")
        self.Transaction_Convert.setValue(AnalyticsParameterCurrency, forKey: "currencyCode")
        self.Transaction_Convert.setValue(AnalyticsParameterItemList, forKey: "list")
        self.Transaction_Convert.setValue(AnalyticsParameterCheckoutStep, forKey: "step")
        self.Transaction_Convert.setValue(AnalyticsParameterCheckoutOption, forKey: "option")
    }
    
    // MARK: 전자상거래 단계별 코드
    func EcommerceStep(StepKey : AnyObject) throws -> String{
        guard let Step_Value = self.EcommerceStep_Convert.object(forKey: StepKey) as? String else{
            throw TypeError.requiredValue
        }
        return Step_Value
    }
    // MARK: 전자상거래 거래항목 코드
    func TransactionValue(returnAction : [String:AnyObject]) throws -> [String:AnyObject]{
        var actiondata = [String:AnyObject]()
        let actionKey = returnAction.keys
        for key in actionKey {
            if returnAction[key] != nil{
                guard let convert_action = self.Transaction_Convert.object(forKey: key) as? String else{
                    throw TypeError.invaildField
                }
                let Value = try Errorfunction.TypeCasting(jsondata: returnAction, CheckValue: key)
                actiondata.updateValue(Value, forKey: convert_action)
            }
        }
        return actiondata
    }
    
    
    // MARK: 상품설정
    func ProductValue(Products:[AnyObject], Count:Int) throws -> Array<Any>{
        var productpush = Array<Any>()
        var PRODUCT = [String:AnyObject]()
        for value in 0..<Count{
            guard let Product_Dictionary = Products[value] as? [String:AnyObject] else{
                throw TypeError.invaildType
            }
            let ProductData = Product_Dictionary
            let ProductData_keys = Product_Dictionary.keys
            for Productkey in ProductData_keys {
                let ecommerce_Value = try Errorfunction.TypeCasting(jsondata: ProductData, CheckValue: Productkey)
                if Productkey.contains("dimension") || Productkey.contains("metric"){
                    PRODUCT.updateValue(ecommerce_Value, forKey: Productkey)
                }else{
                    guard let Convert_key = self.Product_Convert.object(forKey: Productkey) as? String else{
                        throw TypeError.invaildField
                    }
                    PRODUCT.updateValue(ecommerce_Value, forKey: Convert_key)
                }
            }
            productpush.append(PRODUCT)
        }
        return productpush
    }
}
// MARK: GA 하이브리드 처리
class GA{
    func hybirddata(message: WKScriptMessage) throws{
        let data = (message.body as AnyObject).data(using: String.Encoding.utf8.rawValue,allowLossyConversion: false)!
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
            fatalError("\(Error.self)")
        }
        
        //공통 변수 값 설정 - GA 360
        let GAData = NSMutableDictionary.init()
        
        //공통 변수 값 설정 - GA4
        let GA4Data = NSMutableDictionary.init()

        //전송 타입 설정
        let HybridType =  try Errorfunction.TypeCasting(jsondata: json, CheckValue: "type")
        
        //json key 반환
        let jsonAllkey = json.keys
        
        //공통 데이터 설정
        for key in jsonAllkey {
            if key.contains("title"){
                let value = try Errorfunction.TypeCasting(jsondata: json, CheckValue: key)
                GAData.setValue(value, forKey: AnalyticsParameterScreenName)
                GA4Data.setValue(value, forKey: AnalyticsParameterScreenName)
            }
            //하이브리드 공용 맞춤 측정 기준
            if key.contains("dimension") || key.contains("metric") {
                let value = try Errorfunction.TypeCasting(jsondata: json, CheckValue: key)
                GAData.setValue(value, forKey: key)
                CommonData.sharedInstace().USE_WEBDATA.setValue(value, forKey: key)
            }
            if key.lowercased().contains("category"){
                let value = try Errorfunction.TypeCasting(jsondata: json, CheckValue: key)
                GAData.setValue(value, forKey: key)
                GA4Data.setValue(value, forKey: key)
            }
            if key.lowercased().contains("action"){
                let value = try Errorfunction.TypeCasting(jsondata: json, CheckValue: key)
                GAData.setValue(value, forKey: key)
                GA4Data.setValue(value, forKey: key)
            }
            if key.lowercased().contains("label"){
                let value = try Errorfunction.TypeCasting(jsondata: json, CheckValue: key)
                GAData.setValue(value, forKey: key)
                GA4Data.setValue(value, forKey: key)
            }
            if key.lowercased().contains("noninteraction"){ GAData.setValue("1", forKey: key)}
        }
        
        // MARK: GA4 사용자 속성 및 매개변수 설정 코드
        GA.init().setGA4Commondata(Type: "user_property", min: 1, max: 11)
        GA.init().setGA4Commondata(Type: "user_property", min: 17, max: 30)
        GA.init().setGA4Commondata(Type: "event_param", min: 12, max: 16)
        GA.init().setGA4Commondata(Type: "event_param", min: 31, max: 32)

        let addData = try Errorfunction.ObjectTypeCasting(CheckDictionary: CommonData.sharedInstace().Parameter_Data)
        GA4Data.addEntries(from: addData)
        
        if HybridType.contains("screen"){
            //GA로 데이터를 적재하는 시점
            //GTM 내에서 설정할 예정이며, Firebase 이벤트는 차단 설정
            GADataSend(type: "screenview", Data: GAData)
            GADataSend(type: "APPWEB_screenview", Data: GA4Data)
            self.DeleteData()
        }else{
            if json["Products"] != nil {
                guard let Products = json["Products"] as? [AnyObject] else{  throw TypeError.invaildType }
                let EcommerceData = NSMutableDictionary.init()
                
                // MARK: 전자상거래 단계 설정
                let Step = try Errorfunction.TypeCasting(jsondata: json, CheckValue: "EcommerceStep")
                let EcommerceStep = try GA_Ecomerce.init().EcommerceStep(StepKey: Step)
                
                // MARK: 상품설정
                let product_push = Products.count
                let ProductData = try GA_Ecomerce.init().ProductValue(Products: Products, Count: product_push)
                EcommerceData.setValue(ProductData, forKey: AnalyticsParameterItems)
                
                // MARK: 거래설정
                if json["transaction"] != nil {
                    guard let actionData = json["transaction"] as? [String:AnyObject] else{
                        throw TypeError.requiredValue
                    }
                    let Data = try GA_Ecomerce.init().TransactionValue(returnAction: actionData)
                    EcommerceData.addEntries(from: Data)
                }
                EcommerceData.addEntries(from: GAData as! [AnyHashable : Any])
                GADataSend(type: EcommerceStep, Data: EcommerceData)
            }else{
                GADataSend(type: "gaevent", Data: GAData)
                GADataSend(type: "event_click", Data: GA4Data)
            }
            self.DeleteData()
        }
    }
    
    // MARK: GA 데이터 전송 함수
    func GADataSend(type:String, Data:NSMutableDictionary){
        let sendData = Data
        if type.elementsEqual("APPWEB_screenview") || type.elementsEqual("event_click"){
            Analytics.logEvent(AnalyticsEventScreenView, parameters: (sendData as! [String : Any]))
        }else {
            let tracker = GAI.sharedInstance()
            tracker?.tracker(withTrackingId: "UA")
            let UA_CID = tracker?.defaultTracker.get(kGAIClientId)
            sendData.setValue(UA_CID, forKey: "dimension1")
            if sendData["checkout_step"] != nil{
                guard let returnCheck = sendData as? [String:AnyObject] else{ return print("체크아웃 형태 에러") }
                let checkstep = returnCheck["checkout_step"]
                var convertStep = String()
                if (checkstep as? String) == nil {
                    guard let Intvalue = checkstep as? Int else{ return print("checkout 형태 제대로 넣으세용") }
                    convertStep = String(Intvalue)
                }
                if convertStep.contains("2") == true{
                    Analytics.logEvent(AnalyticsEventCheckoutProgress, parameters: (sendData as! [String : Any]))
                }else{
                    Analytics.logEvent(type, parameters: (sendData as! [String : Any]))
                }
            }
            Analytics.logEvent(type, parameters: (sendData as! [String : Any]))
        }
    }
    
    func DeleteData(){
        CommonData.init().USE_WEBDATA.removeAllObjects()
    }
    
    // MARK: 데이터 설정 함수 - Native 용
    func setCommondata(setParameter: String, Key:String){
        CommonData.sharedInstace().USE_WEBDATA.setValue(setParameter, forKey: Key)
    }
    
    // MARK: GA4 데이터 설정 함수
    func setGA4Commondata(Type:String, min:Int, max:Int){
        for index in min...max {
            if Type.elementsEqual("user_property") {
                let UP_value = CommonData.sharedInstace().USE_WEBDATA.value(forKey: "dimension\(index)")
                if UP_value != nil {
                    Analytics.setUserProperty((UP_value as? String), forName: "user_property\(index)")
                }
            }else if Type.elementsEqual("event_param"){
                let EP_value = CommonData.sharedInstace().USE_WEBDATA.value(forKey: "dimension\(index)")
                if EP_value != nil{
                    CommonData.sharedInstace().Parameter_Data.setValue((EP_value as? String), forKey: "event_param\(index)")
                }
            }
        }
    }
}
