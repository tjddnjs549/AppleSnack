//
//  File.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/14.
//

import UIKit

class ProfileViewController:UIViewController, UIImagePickerControllerDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeImageLayer()
        makeTextViewLayer()
        updateProgressView()
        
        if let image = UIImage(named: "cat") {
            profileImage.image = image
        }
        
        blogTextView.delegate = self
        githubTextView.delegate = self
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        toggleFieldState(nameField, sender: sender)
        toggleFieldState(emailField, sender: sender)
        toggleTextViewState(blogTextView, sender: sender)
        toggleTextViewState(githubTextView, sender: sender)
        profileImage.isUserInteractionEnabled.toggle()
    }
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var blogTextView: UITextView!
    
    @IBOutlet weak var githubTextView: UITextView!
    
    
    @IBOutlet weak var progressView: UIProgressView!
        
    @IBOutlet weak var currentValueLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    var dataArray: [Any] = [1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3] // 임시
    var currentValue: Float = 0.0
    var level: Int = 0
    var maxValue: Float = 100
    func updateProgressView() {
        currentValue = Float(dataArray.count)
        if currentValue > maxValue {
            currentValue -= maxValue
            print("\(currentValue)")
            print("\(maxValue)")
            level += 1
            levelLabel.text = "Lv: \(level)"
        }
        
        progressView.progress = currentValue / maxValue
        currentValueLabel.text = "\(Int(currentValue))℃"
        let progressBarFrame = progressView.frame
        let labelXPosition = progressBarFrame.origin.x + progressBarFrame.size.width * CGFloat(currentValue / maxValue)
        currentValueLabel.frame.origin.x = labelXPosition
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
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
        return false
    }
}