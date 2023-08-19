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
    var snackManager = SnackManager.shared
    
    // 데이터 변수 -> 나오는 걸 보기 위해 선언
    var mainTitle: String?
    var content: String?
    var url: String?
    var category: String? = "클래스"
    
    
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
        
        self.title = category
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        
    
        
        let updateButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(updateButtonTapped))
        
        updateButton.tintColor = .orange
        navigationItem.rightBarButtonItem = updateButton
        
        let backButton = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(backButtonTapped))
        
        backButton.tintColor = .orange
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func updateButtonTapped() {
        performSegue(withIdentifier: "ToWriteVC", sender: self)
        //수정 페이지 보냄
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(#function)
        if segue.identifier == "ToWriteVC" {
            let writeVC = segue.destination as! WriteViewController
            writeVC.mainTitle = titleLabel.text
            writeVC.content = contextLabel.text
            writeVC.url = urlContextLabel.text
            print(snackManager.getSnackFromCoreData().count)
            writeVC.category = "클래스"
            // 위처럼 하면 에러발생 (스토리보드 객체가 나중에 생김)
        }
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

