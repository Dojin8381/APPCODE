//
//  HeaderView.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/02/24.
//  컬렉션 뷰 헤더 영역 이미지 추가

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImage.init(named: "Goldenplanet.png")!
        let imageView = UIImageView(image: iv)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        //set header image center
        setupGradientLayer()

    }

    //header 넣을 내용 추가 및 레이아웃 설정
    fileprivate func setupGradientLayer(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1]
        
        let heabyLabel = UILabel()
        heabyLabel.text = "건강 데이터"
        heabyLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        heabyLabel.textColor = .black
        addSubview(heabyLabel)
        heabyLabel.translatesAutoresizingMaskIntoConstraints = false
        heabyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        heabyLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        heabyLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//let gradientView = UIView()
//addSubview(gradientView)
//gradientView.translatesAutoresizingMaskIntoConstraints = false
//gradientView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//gradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//gradientView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//gradientView.layer.addSublayer(gradient)
//gradientView.frame = self.bounds
//gradientView.frame.origin.y -= bounds.height
