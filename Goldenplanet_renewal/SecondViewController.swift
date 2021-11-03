//
//  SecondViewController.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/02/24.
//

import UIKit
import Firebase

class SecondViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    fileprivate let headerId = "headerId"
    var collectionOption = [String]()
    var ButtonText = String()
    let padding : CGFloat = 16
    
    override func viewWillAppear(_ animated: Bool) {
        //상단 내비 게이션 숨김처리
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionOption = ["하루 걸음 수", "일주일 걸음 수", "목표 걸음 수", "칼로리 측정"]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpCollectionViewLayout()
        setUpcollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var TEST = ""
    }
    fileprivate func setUpCollectionViewLayout() {
        //collection view layout set
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            //layout 간격설정
            //layout.minimumLineSpacing = 40
        }
    }
    
    fileprivate func setUpcollectionView() {
        collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        //header set
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    //header method
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return collectionOption.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
        // Configure the cell
        cell.layer.cornerRadius = 12
        cell.CollectLabel.setTitle(self.collectionOption[indexPath.row], for: .normal)
        cell.CollectLabel.titleLabel?.font = UIFont(name: "Futura", size: 19)
        cell.CollectLabel.setTitleColor(.black, for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //collection 영역에 대한 padding 계산
        return .init(width: view.frame.width - 2 * padding, height: 80)
    }
    
    //전역변수 합침용 코드
//    func NativeCode() -> NSMutableDictionary{
//        let SET_Native = NSMutableDictionary.init()
//        let SETDATA = CommonData.sharedInstace().USE_WEBDATA
//        if SETDATA.allKeys.count > 0{
//            for key in SETDATA.allKeys {
//                SET_Native.setValue(SETDATA[key], forKey: key as! String)
//            }
//        }
//        return SET_Native
//    }
    //cell button click method
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let Screen = NSMutableDictionary()
        Screen.setValue("ABC_탭선택_구분자_다시", forKey: "category")
        Screen.setValue("ABC_클릭", forKey: "action")
        Screen.setValue("{{선택값}}", forKey: "label")
        Screen.setValue("하이브리드 로드 전", forKey: AnalyticsParameterScreenName)
        
//        GA.init().GADataSend(type: "gaevent", Data: Screen)
//        GA.init().GADataSend(type: "event_click", Data: Screen)
        if indexPath.row == 0 {
            //화면에 이어지기 위해선 Storyboard에 Segue를 지정해야함
            performSegue(withIdentifier: "GAView", sender: self)
        }
        if indexPath.row == 1 {
            //화면에 이어지기 위해선 Storyboard에 Segue를 지정해야함
            performSegue(withIdentifier: "GAView1", sender: self)
        }
        if indexPath.row == 2 {
            //화면에 이어지기 위해선 Storyboard에 Segue를 지정해야함
            performSegue(withIdentifier: "GAView2", sender: self)
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
