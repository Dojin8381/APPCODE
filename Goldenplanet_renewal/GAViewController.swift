//
//  GAViewController.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/01.
//

import UIKit

class GAViewController: UICollectionViewController {

    let GAOption : [String] = ["Custom Dimension", "Page View", "Event", "Ecommerce", "Campaign", "Hybird"]
    let cellId = "cellId2"
    let GApadding : CGFloat = 16
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation title color set
        collectionView.delegate = self
        collectionView.dataSource = self 
        GAsetUpcollectionView()
        setGAUpCollectionViewLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GAOption.count
    }
    
    fileprivate func setGAUpCollectionViewLayout() {
        //collection view layout set
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = .init(top: GApadding, left: GApadding, bottom: GApadding, right: GApadding)
            //layout 간격설정
            //layout.minimumLineSpacing = 40
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath) as! GACollectionViewCell
        cell.layer.cornerRadius = 12
        cell.widthAnchor.constraint(equalToConstant: 350).isActive = true
        cell.heightAnchor.constraint(equalToConstant: 150).isActive = true
        cell.GACollectLabel.setTitle(self.GAOption[indexPath.row], for: .normal)
        cell.GACollectLabel.titleLabel?.font = UIFont(name: "Futura", size: 19)
        cell.GACollectLabel.setTitleColor(.black, for: .normal)
       
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //collection 영역에 대한 padding 계산
//        return .init(width: view.frame.width - 2 * GApadding, height: 80)
//    }
    fileprivate func GAsetUpcollectionView() {
        let textAttr = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttr
        //상단 내비 게이션 활성화
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Google Analytics"
        collectionView.register(GACollectionViewCell.self, forCellWithReuseIdentifier: "cellId2")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
