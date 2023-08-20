//
//  DetailPageViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/14.
//

import UIKit


final class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!
    @IBOutlet weak var urlContextLabel: UILabel!
    
    var mySnack: MySnack?
    var snackNumber = 0
    var snackManager = SnackManager.shared
    

    var category: String? = "클래스"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        configureUI()
        contextLabel.textAlignment = .justified
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
      }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
      }

    
    // MARK: - configureUI 세팅

    private func configureUI() {
        
        titleLabel.text = mySnack?.title
        contextLabel.text = mySnack?.text
        urlContextLabel.text = mySnack?.assiURL
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

    }
    
    
    
    // MARK: - 네비게이션 바 설정
    
    private func setupNaviBar() {
        
        self.title = mySnack?.categorie
        
        let updateButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: #selector(updateButtonTapped))
        
        
        navigationItem.rightBarButtonItem = updateButton
        
        let backButton = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(backButtonTapped))
        
        
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
            writeVC.snackNumber = snackNumber
            writeVC.mySnack = mySnack
            writeVC.category = "클래스"
        }
    }
    @objc func backButtonTapped() {
        let vc = self.navigationController?.viewControllers[1] as! SnackListController
        self.navigationController?.popToViewController(vc, animated: true)
    }

    
}

