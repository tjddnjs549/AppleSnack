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
            categorieLabel.backgroundColor = .green
            categorieLabel.text = categorie
        }
    }
    
    
    
}
