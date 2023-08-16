//
//  ViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var floatingStackView: UIStackView!
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var fixButton: UIButton!
    @IBOutlet weak var deletButton: UIButton!
    
    lazy var floatingDimView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.alpha = 0
        view.isHidden = true
        
        self.view.insertSubview(view, belowSubview: self.floatingStackView)
        
        return view
                          
    }()
    
    var isShowFloating: Bool = false
    
    lazy var buttons: [UIButton] = [self.fixButton, self.deletButton]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func floatingButtonAction(_ sender: UIButton) {
        
        if isShowFloating {
            buttons.reversed().forEach { button in
                UIView.animate(withDuration: 0.3){
                    button.isHidden = true
                    self.view.layoutIfNeeded()
                    
                }
            }
            
            UIView.animate(withDuration: 0.5, animations:  {
                self.floatingDimView.alpha = 0
            }) { (_) in
                self.floatingDimView.isHidden = true
            }
        } else {
            self.floatingDimView.isHidden = false
            
            UIView.animate(withDuration: 0.5) {
                self.floatingDimView.alpha = 1
            }
            
            buttons.forEach { [weak self] button in
                button.isHidden = false
                button.alpha = 0
                
                UIView.animate(withDuration: 0.5) {
                    button.alpha = 1
                    self?.view.layoutIfNeeded()
                    
                }
            }
            
        }
        
        isShowFloating = !isShowFloating
        
        let image = isShowFloating ? UIImage(named: "Hide") : UIImage(named: "Show")
        let roatation = isShowFloating ? CGAffineTransform(rotationAngle: .pi - (.pi / 1)) : CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.3) {
            sender.setImage(image, for: .normal)
            sender.transform = roatation
        }
                                                        
    }
   

}

