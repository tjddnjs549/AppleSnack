//
//  File.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/14.
//

import UIKit

class ProfileViewController:UIViewController, UINavigationControllerDelegate {
    let profileManager = ProfileManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profileData = profileManager.getProfileCoreData().first {
            nameField.text = profileData.name
            githubTextView.text = profileData.github
            blogTextView.text = profileData.blog
            emailField.text = profileData.email
            
            if let imageDate = profileData.photo, let image = UIImage(data: imageDate) {
                profileImage.image = image
            }
        }
        
        makeImageLayer()
        makeTextViewLayer()
        updateProgressView()
        
        blogTextView.delegate = self
        githubTextView.delegate = self
        // 옵저버를 추가해서 업데이트 요청을 받음
        NotificationCenter.default.addObserver(self, selector: #selector(requestProgressUpdate), name: NSNotification.Name( "RequestProgressUPdate"), object: nil)
    }
    
    @objc func requestProgressUpdate() {
        updateProgressView()
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        toggleFieldState(nameField, sender: sender)
        toggleFieldState(emailField, sender: sender)
        toggleTextViewState(blogTextView, sender: sender)
        toggleTextViewState(githubTextView, sender: sender)
        profileImage.isUserInteractionEnabled.toggle()
        
        if let profileData = profileManager.getProfileCoreData().first {
            profileData.name = nameField.text
            profileData.github = githubTextView.text
            profileData.blog = blogTextView.text
            profileData.email = emailField.text
            
            if let newImage = profileImage.image {
                profileData.photo = newImage.pngData()
            }
            
            profileManager.updateProfile(newToDoData: profileData) {}
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var blogTextView: UITextView!
    
    @IBOutlet weak var githubTextView: UITextView!
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var currentValueLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var currentValueLabelLeadingConstraint: NSLayoutConstraint!
    
    var dataArray: [Any] = [1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2] // 임시
    var currentValue: Float = 0.0
    var level: Int = 0
    var maxValue: Float = 100
    
    func updateProgressView() {
        currentValue = Float(dataArray.count)
        let repeatedValue = currentValue.truncatingRemainder(dividingBy: maxValue)
        if repeatedValue == 0 && currentValue != 0 {
            level += 1
            levelLabel.text = "Lv: \(level)"
        }
        
        progressView.progress = repeatedValue / maxValue
        currentValueLabel.text = "\(Int(repeatedValue))℃"
        let ratio = CGFloat(repeatedValue / maxValue)
        
        currentValueLabelLeadingConstraint.constant = progressView.bounds.width * ratio
    }
    
    func toggleFieldState(_ field: UITextField, sender: UIBarButtonItem) {
        field.isEnabled.toggle()
        
        if field.isEnabled {
            sender.title = "완료"
        } else {
            sender.title = "수정"
        }
    }
    
    func toggleTextViewState(_ textView: UITextView, sender: UIBarButtonItem) {
        textView.isEditable.toggle()
        
        if textView.isEditable {
            sender.title = "완료"
        } else {
            sender.title = "수정"
        }
    }
}
