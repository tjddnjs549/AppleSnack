//
//  ProfileTextViewDelegate.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/18.
//

import UIKit

extension ProfileViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        }
        return false
    }
}
