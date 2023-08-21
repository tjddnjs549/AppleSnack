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
    
    @IBOutlet weak var sv: UIView!
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var snackTextLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    func setUI() {
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 10
        cellView.backgroundColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00)
        snackTextLabel.layer.addBorder([.top], color: UIColor(red: 0.34, green: 0.70, blue: 0.60, alpha: 1.00), width: 1.0)
        cellLabel.backgroundColor = .clear
        snackTextLabel.textColor = cellLabel.textColor
        snackTextLabel.clipsToBounds = true
        snackTextLabel.layer.cornerRadius = 3
        
        
    }

}
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
