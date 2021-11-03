//
//  GAThread.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/06.
//


import Foundation
import AdSupport
func gaThread(dict: Dictionary<String, String>){
    let setdata = NSMutableDictionary()
    let GP_Async = DispatchQueue(label: "GP_Async", qos: .userInitiated, attributes: .concurrent )
    setdata.setValue("UA-115948787-1", forKey: "tid")
    setdata.setValue(getcid.sharedInstance().clientid, forKey: "cid")
    setdata.setValue("web", forKey: "ds")
    setdata.setValue("1", forKey: "aip")
    let IDFA = ASIdentifierManager.shared().advertisingIdentifier
    let strIDFA = IDFA.uuidString
    if !strIDFA.isEmpty{
        setdata.setValue(strIDFA, forKey: "idfa")
    }
    for (key,value) in dict{
        if(key.contains("cd")){ setdata.setValue(value, forKey: key) }
        if(key.contains("cm")){ setdata.setValue(value, forKey: key) }
        if key == "t"{ setdata.setValue(value, forKey: key) }
        if key == "dl"{ setdata.setValue(value, forKey: key) }
        if key == "dt"{ setdata.setValue(value, forKey: key) }
        if key == "ec"{ setdata.setValue(value, forKey: key) }
        if key == "ea"{ setdata.setValue(value, forKey: key) }
        if key == "el"{ setdata.setValue(value, forKey: key) }
        if key == "ev"{ setdata.setValue(value, forKey: key) }
        if key == "cn"{ setdata.setValue(value, forKey: key) }
        if key == "cs"{ setdata.setValue(value, forKey: key) }
        if key == "cm"{ setdata.setValue(value, forKey: key) }
        if key == "ck"{ setdata.setValue(value, forKey: key) }
        if key == "cc"{ setdata.setValue(value, forKey: key) }
        if key == "ci"{ setdata.setValue(value, forKey: key) }
        if key == "sr"{ setdata.setValue(value, forKey: key) }
        if key == "ul"{ setdata.setValue(value, forKey: key) }
        if key == "cu"{ setdata.setValue(value, forKey: key) }
        if key == "ni"{ setdata.setValue(value, forKey: key) }
        if key == "pa"{ setdata.setValue(value, forKey: key) }
        if key == "ti"{ setdata.setValue(value, forKey: key) }
        if key == "uid" { setdata.setValue(value, forKey: key) }
        if key == "ta"{ setdata.setValue(value, forKey: key) }
        if key == "tr"{ setdata.setValue(value, forKey: key) }
        if key == "ts"{ setdata.setValue(value, forKey: key) }
        if key == "tt"{ setdata.setValue(value, forKey: key) }
        if key == "tcc"{ setdata.setValue(value, forKey: key) }
        if key == "pal"{ setdata.setValue(value, forKey: key) }
        if key == "cos"{ setdata.setValue(value, forKey: key) }
        if key == "col"{ setdata.setValue(value, forKey: key) }
        if key == "aid"{ setdata.setValue(value, forKey: key) }
        if key == "av"{ setdata.setValue(value, forKey: key) }
        if key == "an"{ setdata.setValue(value, forKey: key) }
        if(key.contains("il")){ setdata.setValue(value, forKey: key) }
        if(key.contains("pr")){ setdata.setValue(value, forKey: key) }
    }
    

//    GP_Async.async {
//        <#code#>
//    }
    DispatchQueue.global(qos: .utility).async {
        hitsend(dataset: setdata)
    }
}

func hitsend(dataset : NSMutableDictionary){
    var query = "v=1"
    for (key, value) in dataset{
        let T : String = value as! String
        let A : String = key as! String
        query = query + "&"
        query = query + A
        query = query + "="
        query = query + T
    }
    let GAURL = String(format: "https://www.google-analytics.com/collect")
    var request = URLRequest(url: URL(string: GAURL)!)
    let post = String(format:"\(query)")
    let encode_post = post.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn:"!*'();:@+$,/%#[]{} ").inverted)
    let postData = encode_post!.data(using: .utf8, allowLossyConversion: true)
    
    let postLength = String(postData!.count)
    request.httpMethod = "POST"
    request.setValue(postLength, forHTTPHeaderField: "Content-Length")
    request.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,*-*;q=0.8", forHTTPHeaderField: "Accept")
    request.httpBody = postData
    let OS_device = getcid.sharedInstance().Device
    let Add_version = OS_device.components(separatedBy: ".")
    var OS_Value = Add_version[0] + "_" + Add_version[1]
    if(Add_version.count > 2){
        OS_Value = OS_Value + "_" + Add_version[2]
    }

    request.setValue("NativeAPP/5.0 (iPhone; CPU iPhone OS \(OS_Value) like Mac OS X)", forHTTPHeaderField: "User-Agent")
    let oResponseData = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let httpresponse = response as? HTTPURLResponse{
            print("statusCode: \(httpresponse.statusCode)")
        }
        let httperror = response as? HTTPURLResponse
        if httperror?.statusCode != 200{
            print("error :\(String(describing: httperror?.statusCode))")
        }else{
            do{
                //Swift Log 출력
                let dae = try JSONSerialization.data(withJSONObject: dataset, options: .prettyPrinted)
                let dataString = String(data: dae, encoding: .utf8)
                print("\nGAData : \(dataString as AnyObject)")
            }catch{
                print("jSONError : ", error)
            }
        }
    }
    oResponseData.resume()
}


//    request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS \(OS_Value) like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B137 Safari/601.1", forHTTPHeaderField: "User-Agent")
//    request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS \(OS_Value) like Mac OS X)", forHTTPHeaderField: "User-Agent")
//    request.setValue("(iPhone; CPU iPhone OS \(OS_Value)", forHTTPHeaderField: "User-Agent")
//    request.setValue("NativeAPP/5.0 (iPhone; CPU iPhone OS \(OS_Value) like Mac OS X) NativeAPP/601.1.46 (KHTML, like Gecko) Version/13.0 NativeAPP/13B137", forHTTPHeaderField: "User-Agent")

