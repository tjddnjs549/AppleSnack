//
//  SnackListCellTableViewCell.swift
//  AppleSnack
//
//  Created by Macbook on 2023/08/19.
//

import UIKit

class SnackListCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    func setUI() {
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 10
        
        //❗️이쪽 바꿈 -> 색 조정
//        cellView.backgroundColor = .lightGray
//        cellLabel.textColor = .black
        cellLabel.backgroundColor = .clear
        
    }

}
