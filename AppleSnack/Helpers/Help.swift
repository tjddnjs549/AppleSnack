//
//  Help.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/15.
//

import UIKit


// MARK: - ProfileViewController

extension ProfileViewController {
    func makeImageLayer() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.masksToBounds = true // imageView 안으로 제한
        profileImage.layer.borderWidth = 2.0
        profileImage.layer.borderColor = UIColor.black.cgColor
    }
    
    func makeTextViewLayer() {
        blogTextView.layer.borderWidth = 1.0
        blogTextView.layer.borderColor = UIColor.gray.cgColor
        blogTextView.layer.cornerRadius = 10
        
        githubTextView.layer.borderWidth = 1.0
        githubTextView.layer.borderColor = UIColor.gray.cgColor
        githubTextView.layer.cornerRadius = 10
    }
}


// MARK: - WriteViewController

extension WriteViewController {
    
    
    func setup() {
        contextTextView.delegate = self
        urlTextView.delegate = self
        titleTextField.delegate = self
        
        contextTextView.layer.borderWidth = 2.0
        contextTextView.layer.borderColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00).cgColor
        contextTextView.layer.cornerRadius = 12
        
        urlTextView.layer.borderWidth = 2.0
        urlTextView.layer.borderColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00).cgColor
        urlTextView.layer.cornerRadius = 12
        
        titleTextField.layer.borderWidth = 2.0
        titleTextField.layer.cornerRadius = 12
        titleTextField.layer.borderColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00).cgColor
        titleTextField.clearButtonMode = .always //오른쪽에 'x' 버튼
        titleTextField.returnKeyType = .next //리턴 버튼 수정
    }
}
