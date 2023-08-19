//
//  MainCollectionViewCell.swift
//  AppleSnack
//
//  Created by  on 2023/08/17.
//

import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet var newCell: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
        label.numberOfLines = 0 // Allow multiple lines
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.lightGray : UIColor.white
        }
    }
    func configure(text: String) {
        label.text = text
    }
    
}
