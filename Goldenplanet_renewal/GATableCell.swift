//
//  GATableCell.swift
//  Goldenplanet_renewal
//
//  Created by DOJIN KIM on 2021/03/02.
//

import UIKit

class GATableCell: UITableViewCell {

    let TableText: UITextField = {
        var TableText = UITextField()
        TableText.font = UIFont.systemFont(ofSize: 20)
        
        return TableText
    }()
    var placehoder : String? {
        didSet {
            guard let item = placehoder else {return}
            TableText.placeholder = item
        }
    }
    func initConstraints(){
        addSubview(TableText)
        TableText.translatesAutoresizingMaskIntoConstraints = false
        TableText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        TableText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        TableText.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initConstraints()
        endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //table 선택 시 발생되는 메소드, set해주는 개념
    //table 선택 시 해당 함수가 호출 됨.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
