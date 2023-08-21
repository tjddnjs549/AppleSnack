//
//  MainCollectionViewCell.swift
//  AppleSnack
//
//  Created by  on 2023/08/17.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categorieLabel: UILabel!
    
    var categorie: String? {
        didSet {
            categorieLabel.backgroundColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00)
            categorieLabel.text = categorie
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
