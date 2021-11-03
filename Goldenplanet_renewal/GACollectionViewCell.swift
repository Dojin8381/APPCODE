//
//  GACollectionViewCell.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/02.
//

import UIKit

class GACollectionViewCell: UICollectionViewCell {
    let GACollectLabel: UIButton = {
        var GACellButton = UIButton()
        return GACellButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        addSubview(GACollectLabel)
        GACollectLabel.translatesAutoresizingMaskIntoConstraints = false
        GACollectLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        GACollectLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
