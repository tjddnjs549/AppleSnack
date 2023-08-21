//
//  CollectionViewCell.swift
//  AppleSnack
//
//  Created by Macbook on 2023/08/15.
//

import UIKit

class WWDCcell: UICollectionViewCell {
    
    var yearText: String? {
        didSet {
            year.text = yearText
        }
    }

    
    let year: UILabel = {
        let year = UILabel()
        year.backgroundColor = .clear
        year.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        year.textAlignment = .center
        year.font = .boldSystemFont(ofSize: 25)
        return year
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 내장되어 있는 contentView에 라운드 처리를 한다.
        self.contentView.addSubview(year)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        
        // 기본값인 view에 그림자 효과를 넣는다.
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: -2, height: 2)
        
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        print("test")
        year.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            year.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            year.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            year.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            year.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
    }
    
}
