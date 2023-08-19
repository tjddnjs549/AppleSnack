//
//  Help.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/15.
//

import UIKit

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

extension WriteViewController {
    
    
//    func makeTextViewLayer() {
//        blogTextView.layer.borderWidth = 1.0
//        blogTextView.layer.borderColor = UIColor.gray.cgColor
//        blogTextView.layer.cornerRadius = 10
//
//        githubTextView.layer.borderWidth = 1.0
//        githubTextView.layer.borderColor = UIColor.gray.cgColor
//        githubTextView.layer.cornerRadius = 10
//    }
}
