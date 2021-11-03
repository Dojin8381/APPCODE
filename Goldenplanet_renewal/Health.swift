//
//  Health.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/08.
//

import Foundation
import HealthKit

class Health{
    public var healthStore = HKHealthStore()
    public var stepValue = String()
    public var RealTime = String()
    public var SUMDate = String()
    public var WeekDay1 = String()
    public var WeekDay2 = String()
    public var WeekDay3 = String()
    public var WeekDay4 = String()
    public var WeekDay5 = String()
    public var WeekDay6 = String()
    public var WeekDay7 = String()
    public var URLString = "http://210.114.9.22/GA_part/identity/tab2.html?"
    struct  StaticInstance {
        static var instance : Health?
    }
    class func sharedInstace() -> Health{
        if(StaticInstance.instance == nil){
            StaticInstance.instance = Health()
        }
        return StaticInstance.instance!
    }
    func getHealthKitPermission(completion:@escaping(Bool) -> Void){
        guard  HKHealthStore.isHealthDataAvailable() else {
            return
        }
        let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        let Health_Data = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingSpeed)
        let Health_Data1 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingStepLength)
        let Health_Data2 = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
        healthStore.requestAuthorization(toShare: [stepCount!,Health_Data!,Health_Data1!,Health_Data2!], read: [stepCount!,Health_Data!,Health_Data1!,Health_Data2!]) { (success, error) in
            if success{
                completion(true)
                
            }else{
                if error != nil{
                    print(error.debugDescription)
                }
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func DateFormat(convertdate: String) -> NSDate{
        let StringtoDate = convertdate
        let default_date = "yyyy-MM-dd'T'HH:mm:ss"
        let gregorian = Calendar.init(identifier: .gregorian)
        let USLocale = Locale.init(identifier: "en_US_POSIX")
        let date_format = DateFormatter()
        date_format.dateFormat = default_date
        date_format.calendar = gregorian
        date_format.locale = USLocale
        
        let date = date_format.date(from: StringtoDate)

        return date! as NSDate
    }
    
    func getStepValue(sampleType : HKSampleType, predicate: NSPredicate, toString: String){
        var dailyValue = 0
        var dataString = String()
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 0, sortDescriptors: nil) { (query, results, error) -> Void in
            DispatchQueue.main.async{
                guard error == nil else {
                    print("error")
                    return
                }
                for result in results! {
                    guard  let currD:HKQuantitySample = result as? HKQuantitySample else {
                        return
                    }
                    dailyValue += Int(currD.quantity.doubleValue(for: HKUnit.count()))
                }
                if dailyValue != 0 {dataString = String(dailyValue)}
                print("Walking Data : \( dataString)" )
                if toString.contains("리얼"){
                    Health.sharedInstace().RealTime = dataString
                    self.setString(set: Health.sharedInstace().RealTime, toCheck: toString)
                }else if toString.contains("누적"){
                    Health.sharedInstace().SUMDate = dataString
                    self.setString(set: Health.sharedInstace().SUMDate, toCheck: toString)
                }else if toString.contains("1일차"){
                    Health.sharedInstace().WeekDay1 = dataString
                }else if toString.contains("2일차"){
                    Health.sharedInstace().WeekDay2 = dataString
                }else if toString.contains("3일차"){
                    Health.sharedInstace().WeekDay3 = dataString
                }else if toString.contains("4일차"){
                    Health.sharedInstace().WeekDay4 = dataString
                }else if toString.contains("5일차"){
                    Health.sharedInstace().WeekDay5 = dataString
                }else if toString.contains("6일차"){
                    Health.sharedInstace().WeekDay6 = dataString
                }else if toString.contains("7일차"){
                    Health.sharedInstace().WeekDay7 = dataString
                }
                var GG = ""
            }
        }
        Health.sharedInstace().healthStore.execute(query)
    }
    func setString(set: String, toCheck:String) -> Void{
        let setURL = set
        if(toCheck.contains("리얼")){
            Health.sharedInstace().stepValue =  "today=" + setURL
        }else{
            Health.sharedInstace().stepValue = "&stack_time=" + setURL
        }
        Health.sharedInstace().URLString = Health.sharedInstace().URLString + Health.sharedInstace().stepValue
    }
    
    func WeekDate(week_start : NSDate, week_end : NSDate) -> Void{
        let start = week_start
        let end = week_end
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        //일주일 걸음 수 코딩 최소화
        for i in 1...7 {
            let Day = start
            //처음 시작할때만 스타트 기준으로 값 가져오기
            if i == 1 {
                let predicate = HKQuery.predicateForSamples(withStart: start as Date , end: Day.addingTimeInterval(TimeInterval(86400 * i)) as Date, options: .strictStartDate)
                //로그 확인용
                print("CallPoint : \(start) with ENDPoint : \(Day)" )
                Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate, toString: "\(i)일차")
            }else{
                //이후 for in 설정 값
                let predicate1 = HKQuery.predicateForSamples(withStart: Day.addingTimeInterval(TimeInterval(86400 * (i-1))) as Date , end: Day.addingTimeInterval(TimeInterval(86400 * i)) as Date, options: .strictStartDate)
                Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate1, toString: "\(i)일차")
                //로그 확인용
                print("CallPoint : \(Day.addingTimeInterval(TimeInterval(86400 * (i-1)))) with ENDPoint : \(Day.addingTimeInterval(TimeInterval(86400 * i)))" )
            }
            var K = ""
        }

    }
}
//let Day1 = start.addingTimeInterval(86400)
//let Day2 = start.addingTimeInterval(178200)
//let Day3 = start.addingTimeInterval(259200)
//let Day4 = start.addingTimeInterval(345600)
//let Day5 = start.addingTimeInterval(432000)
//let Day6 = start.addingTimeInterval(518400)
//let Day7 = start.addingTimeInterval(604800)
//let predicate = HKQuery.predicateForSamples(withStart: start as Date , end: Day1 as Date, options: .strictStartDate)
//Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate, toString: "1일차")
//
//let predicate1 = HKQuery.predicateForSamples(withStart: Day1 as Date , end: Day2 as Date, options: .strictStartDate)
//Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate1, toString: "2일차")
//
//let predicate2 = HKQuery.predicateForSamples(withStart: Day2 as Date , end: Day3 as Date, options: .strictStartDate)
//Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate2, toString: "3일차")
//
//let predicate3 = HKQuery.predicateForSamples(withStart: Day3 as Date , end: Day4 as Date, options: .strictStartDate)
//Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate3, toString: "4일차")
//
//let predicate4 = HKQuery.predicateForSamples(withStart: Day4 as Date , end: Day5 as Date, options: .strictStartDate)
//Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate4, toString: "5일차")
//
//let predicate5 = HKQuery.predicateForSamples(withStart: Day5 as Date , end: Day6 as Date, options: .strictStartDate)
//Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate5, toString: "6일차")
//
//let predicate6 = HKQuery.predicateForSamples(withStart: Day6 as Date , end: end as Date, options: .strictStartDate)
//Health.sharedInstace().getStepValue(sampleType: stepsQuantityType, predicate: predicate6, toString: "7일차")
