//
//  AppDelegate.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/02/23.
//

import UIKit
import AppTrackingTransparency
import Firebase
import HealthKit
// MARK: getcid
class getcid{
    public var clientid = Analytics.appInstanceID()
    
    public var Device = UIDevice.current.systemVersion
    public var url_data = String()
    struct StaticInstance{
        static var instance : getcid?
    }
    class func sharedInstance() ->getcid{
        if(StaticInstance.instance == nil){
            StaticInstance.instance = getcid()
        }
        return StaticInstance.instance!
    }
}



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ATTrackingManager.requestTrackingAuthorization { (stauts) in
            switch stauts{
            case .notDetermined:
                print("동의구함")
            case .restricted:
                print("거절")
            case .denied:
                print("제한하다")
            case .authorized:
                print("권한동의")
            @unknown default:
                print("alert")
            }
        }
        Health.sharedInstace().getHealthKitPermission { (bool) in
            if true{
                print("success")
            }
        }
        
        // MARK: 디버그 뷰 설정
        var Debug_set = ProcessInfo.processInfo.arguments
        Debug_set.append("-FIRDebugEnabled")
        ProcessInfo.processInfo.setValue(Debug_set, forKey: "arguments")
        
        FirebaseApp.configure()
        getcid.sharedInstance().clientid = Analytics.appInstanceID()
        getTodaysSteps { (_) in
            print("success")
        }
    
        #if DEBUG
        #endif
        // MARK: GA설정
        let gai = GAI.sharedInstance()!

        gai.trackUncaughtExceptions = true
        gai.logger.logLevel = GAILogLevel.verbose
        
        gai.dispatchInterval = 1
        Analytics.setUserID("TEST_DJKIM")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Fail")
                completion(0.0)
                return
            }
            DispatchQueue.main.async {
                completion(sum.doubleValue(for: HKUnit.count()))
                let Q = sum.doubleValue(for: HKUnit.count())
                if Q != 0 {getcid.sharedInstance().url_data = String(Int(Q))}
                return self.RealTimeStepCount { (_) in
                    print("next_data")
                }
            }
        }
        Health.sharedInstace().healthStore.execute(query)
    }

    func RealTimeStepCount(completion: @escaping (Double) -> Void){
        var stepsQuantityType : HKSampleType
        stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = NSDate.init()
        //걸음 데이터의 경우, 몇시간 간격으로 데이터를 가져오나봄
        //-3000초에 1번 -10000 2번 12000 3개
        //걸은기록이없어서 데이터를 못가져오나봄
        let startOfDay = now.addingTimeInterval(-30600)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay as Date , end: now as Date, options: .strictStartDate)
        Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate, toString: "리얼")
        Health.sharedInstace().RealTime = Health.sharedInstace().stepValue
        return SUMStepCount()
    }
  
    func SUMStepCount(){
        let StartDate = Health.sharedInstace().DateFormat(convertdate: "2020-01-01T00:00:00")
        let EndDate = Health.sharedInstace().DateFormat(convertdate: "2200-12-31T00:00:00")
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let predicate = HKQuery.predicateForSamples(withStart: StartDate as Date , end: EndDate as Date, options: .strictStartDate)
        Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate, toString: "누적")
        
    }
    
}

