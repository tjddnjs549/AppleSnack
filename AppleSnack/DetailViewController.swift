//
//  DetailPageViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/14.
//

import UIKit

final class DetailViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var urlContextLabel: UILabel!
    
    var mySnack: MySnack?
    
    // 데이터 변수 -> 나오는 걸 보기 위해 선언
    var mainTitle: String?
    var content: String?
    var url: String?
    var category: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        configureUI()
        contextLabel.textAlignment = .justified
    }
    
    // MARK: - configureUI 세팅

    private func configureUI() {
        
        titleLabel.text = mainTitle
        contextLabel.text = content
        urlContextLabel.text = url
//        if let mySnack = self.mySnack {
//
//            guard let text = mySnack.title, let context = mySnack.text, let url = mySnack.assiURL else { return }
//
//            titleLabel.text = text
//            contextLabel.text = context
//            urlContextLabel.text = url
//        }
    }
    
    // MARK: - 네비게이션 바 설정
    
    private func setupNaviBar() {
        
        self.title = "상세 페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        
    
        
        let doneButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(doneButtonTapped))
        
        doneButton.tintColor = .orange
        navigationItem.rightBarButtonItem = doneButton
        
        let backButton = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(backButtonTapped))
        
        backButton.tintColor = .orange
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func doneButtonTapped() {
        
        //수정 페이지 보냄
        let storyboard = UIStoryboard(name: "WriteViewStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WriteViewStoryboard") as! WriteViewController
        
        vc.mainTitle = titleLabel.text
        vc.content = contextLabel.text
        vc.url = urlContextLabel.text
        //vc.category = categorie
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backButtonTapped() {
        //백하면 바로 셀있는 뷰로 이동
//        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
//        for viewController in viewControllerStack {
//            if let _ = viewController as? _ {
//                self.navigationController?.popToViewController(_, animated: true)
//            }
//        }
    }

    
}

