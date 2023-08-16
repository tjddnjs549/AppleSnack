//
//  DetailPageViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/14.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var urlContextLabel: UILabel!
    
    var snackManager = SnackManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        
    }
    
    // MARK: - Label 세팅
    
    func setup() {
    
    }

    
    
    
    // MARK: - 네비게이션 바 설정
    
    func setupNaviBar() {
        
        self.title = "상세 페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        
    
        
        let doneButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(plusButtonTapped))
        
        doneButton.tintColor = .orange
        navigationItem.rightBarButtonItem = doneButton
        
        let backButton = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(backButtonTapped))
        
        backButton.tintColor = .orange
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func plusButtonTapped() {
        
        let storyboard = UIStoryboard(name: "WriteViewStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteViewStoryboard") as! WriteViewController
        self.navigationController?.show(vc, sender: nil)
    }
    
    @objc func backButtonTapped() {
//        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
//        for viewController in viewControllerStack {
//            if let _ = viewController as? _ {
//                self.navigationController?.popToViewController(_, animated: true)
//            }
//        }
    }

}
