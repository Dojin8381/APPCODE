//
//  ViewController.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/02/23.
//
// 초기 애니메이션 효과 부여
// 기기별 레이아웃 수정 필요
// iphone8일경우 레이아웃 수정
//        StartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 330).isActive = true
//        StartButton.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -500).isActive = true
//StartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 230).isActive = true

//StartButton.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 500).isActive = true
import UIKit
import Firebase
class ViewController: UIViewController {

    let StartButton = UIButton()
    //set up UI anmiate title
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let CheckLabel = UILabel()
//    let StartButton = UIButton()
    fileprivate func setupTitle(){
        //영역 초과 시 넘버라인으로 기준 설정
        titleLabel.numberOfLines = 0
        titleLabel.text = "Goldenplanet"
        titleLabel.font = UIFont(name: "Futura", size: 40)
        //영역 초과 시 넘버라인으로 기준 설정
        bodyLabel.numberOfLines = 0
        bodyLabel.text = "Renewal BY GP_DJKIM"
        CheckLabel.numberOfLines = 0
        CheckLabel.text = "Click to Here"
        CheckLabel.font = UIFont(name: "Futura", size: 20)
    }
    fileprivate func setupStackView() {
        //타이틀 문구 stackview 설정
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel,CheckLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        //button
        StartButton.setTitle("GA/Firebase 시작하기", for: .normal)
        StartButton.setTitleColor(.black, for: .normal)
        StartButton.titleLabel!.font = UIFont(name: "Futura", size: 20)
        StartButton.alpha = 0
        view.addSubview(StartButton)
        //타이틀문구 위치 설정 auto layout 허용 설정 시 addsubview가 먼저 선언되어야함
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        StartButton.translatesAutoresizingMaskIntoConstraints = false
        StartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        StartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 230).isActive = true
        StartButton.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 500).isActive = true
//        StartButton.heightAnchor.constraint(equalToConstant: 800).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        //상단 내비 게이션 숨김처리
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //색깔 랜덤함수
        setupAnimations()
        //기본 타이틀 body 설정
        setupTitle()
        setupStackView()
        //애니메이션 효과
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations)))
        
        StartButton.addTarget(self, action: #selector(Move), for: .touchUpInside)
        
        let Screen = NSMutableDictionary()
        let GA4Screen = NSMutableDictionary()
        Screen.setValue("last+SCreem", forKey: AnalyticsParameterScreenName)
//        Screen.setValue("ABC_탭선택_구분자_다시", forKey: "category")
//        Screen.setValue("ABC_클릭", forKey: "action")
//        Screen.setValue("{{선택값}}", forKey: "label")
        Screen.addEntries(from: CommonData.sharedInstace().USE_WEBDATA as! [AnyHashable : Any])
        GA4Screen.addEntries(from: CommonData.sharedInstace().Parameter_Data as! [AnyHashable : Any])
        GA4Screen.setValue("그만하자", forKey: AnalyticsParameterScreenName)
//        GA.init().GADataSend(type: "screenview", Data: Screen)
//        GA.init().GADataSend(type: "APPWEB_screenview", Data: GA4Screen)
      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("when")
        GA.init().DeleteData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("last")
    }
    @objc func Move(){
        //collectionView로 넘길떄 해당 레이아웃을 추가해줘야
        performSegue(withIdentifier: "Second", sender: self)
    }
    @objc fileprivate func handleTapAnimations() -> Bool{
        //title animate
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        } completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -150)
            })
        }
        Animate_Label(label: self.bodyLabel)
        Animate_Label(label: self.CheckLabel)
       

        //start animate
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
        } completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 1.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
                self.StartButton.alpha = 1
            })
        }
        return true
    }


    func Animate_Label(label : UILabel){
        let A_label = label
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            A_label.transform = CGAffineTransform(translationX: -30, y: 0)
        } completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:  {
                A_label.alpha = 0
                A_label.transform = A_label.transform.translatedBy(x: 0, y: -150)
            })
        }
    }
    func setupAnimations(){
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: [.repeat, .autoreverse], animations: {
            layer.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor]
        }, completion: nil)
    }
    
}

//버튼클릭시
//        StartButton.addTarget(self, action: #selector(Move), for: .touchUpInside)
//func randomColor() -> UIColor {
//    let randomRed:CGFloat = CGFloat(drand48())
//    let randomGreen:CGFloat = CGFloat(drand48())
//    let randomBlue:CGFloat = CGFloat(drand48())
//    
//    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
//}
//        let Collection = SecondViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        self.present(Collection, animated: true, completion: nil)
//    @objc func Move(){
//        //collectionView로 넘길떄 해당 레이아웃을 추가해줘야
//        self.navigationController?.present((self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController"))!, animated: true, completion: nil)
//    }
