//
//  GATableViewController.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/02.
//

import UIKit

class GATableViewController: UITableViewController, UITextFieldDelegate {

    var GA_Value = String()
    var GA_Value1 = String()
    var GA_Value2 = String()
    var GA_Value3 = String()
    var GA_Value4 = String()
    var GA_Value5 = String()
    var GA_Value6 = String()
    var GA_Value7 = String()
    var GA_Value8 = String()
    var GA_Value9 = String()
    var GA_Value10 = String()
    var GA_Value11 = String()
    var GA_Value12 = String()
    
    let GAT = "cellID"
    let GA_Test = UITextField()
    let GA_Field = ["Dimension1 값을 입력해주세요",
                    "Dimension2 값을 입력해주세요",
                    "Dimension3 값을 입력해주세요",
                    "Dimension4 값을 입력해주세요",
                    "Dimension5 값을 입력해주세요",
                    "Dimension6 값을 입력해주세요",
                    "Dimension7 값을 입력해주세요",
                    "Dimension8 값을 입력해주세요",
                    "Dimension9 값을 입력해주세요",
                    "Dimension10 값을 입력해주세요",
                    "Title 값을 입력해주세요",
                    "location 값을 입력해주세요",
                    "Event_Category 값을 입력해주세요",
                    "Event_Action 값을 입력해주세요",
                    "Event_Label 값을 입력해주세요"]
    
   
    fileprivate func Table_SetUp() {
        tableView.dataSource = self
        tableView.delegate = self
        //cell 등록
        tableView.register(GATableCell.self, forCellReuseIdentifier: GAT)
        //cell Layout 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Google Analytics"
//        navigationController?.navigationBar.prefersLargeTitles = true
        Table_SetUp()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "전송", style: .plain, target: self, action: "transport")
    }
    func transport(){
        tableView.reloadData()
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    //실시간 타이핑 받는 값
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text!)
        return true
    }

    //키보드 return 버튼 클릭 시
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let Check_place = textField.placeholder!
        Check_Value(getValue: textField, for: Check_place)
        self.view.endEditing(true)
        return true
    }

    
    //분기처리 하드코딩 설정
    func Check_Value(getValue : UITextField, for string : String){
        let Check = string
        let text_Value = getValue
        if Check.contains("Dimension1"){ GA_Value = text_Value.text!}
        else if Check.contains("Dimension2"){ GA_Value1 = text_Value.text!}
        else if Check.contains("Dimension3"){ GA_Value2 = text_Value.text!}
        else if Check.contains("Dimension4"){ GA_Value3 = text_Value.text!}
        else if Check.contains("Dimension5"){ GA_Value4 = text_Value.text!}
        else if Check.contains("Dimension6"){ GA_Value5 = text_Value.text!}
        else if Check.contains("Dimension7"){ GA_Value6 = text_Value.text!}
        else if Check.contains("Dimension8"){ GA_Value7 = text_Value.text!}
        else if Check.contains("Dimension9"){ GA_Value8 = text_Value.text!}
        else if Check.contains("Dimension10"){ GA_Value9 = text_Value.text!}
        else if Check.lowercased().contains("title"){ GA_Value10 = text_Value.text! }
//        else if Check.contains("Dimension2"){ GA_Value11 = text_Value.text!}
//        else if Check.contains("Dimension2"){ GA_Value12 = text_Value.text!}
//        bool_value(string: GA_Value)
        var G = ""
    }
//    func bool_value(string : String) -> String{
//        let bool = string
//        return ""
//    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GA_Field.count
    }
    
    //cell 구성 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GAT, for: indexPath) as! GATableCell
        cell.placehoder = GA_Field[indexPath.row]
        cell.TableText.tag = indexPath.row
        cell.TableText.delegate = self
        return cell
    }
   
    //table select method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if GA_Value.isEmpty || GA_Value1.isEmpty{
            let alert = UIAlertController(title: "경고", message: "다시 입력하세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
                tableView.remembersLastFocusedIndexPath = true
                
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }else{
            
        }
       
    }
    
//    if indexPath.row == 0 {
//        if GA_Value.isEmpty == false{
//            var ZZ = tableView.viewWithTag(indexPath.row)?.value(forKey: "text")
//            var GT = String()
//        }
//    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
