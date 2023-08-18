//
//  ProfileImagePickerDelegate.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/18.
//

import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate {
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
            
            profileManager.saveToDoData(name: nameField.text, photo: selectedImage.pngData(), git: githubTextView.text, blog: blogTextView.text) {}
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
