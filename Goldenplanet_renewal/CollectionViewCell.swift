//
//  CollectionViewCell.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/02/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let CollectLabel: UIButton = {
        var CellButton = UIButton()
        return CellButton
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        addSubview(CollectLabel)
        CollectLabel.translatesAutoresizingMaskIntoConstraints = false
        CollectLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        CollectLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
