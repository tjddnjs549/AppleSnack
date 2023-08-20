//
//  WriteUITextFieldDelegate.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/20.
//

import UIKit


// MARK: - UITextFieldDelegate

extension WriteViewController: UITextFieldDelegate {
    
    //제목에서 키보드 다음버튼 누르면 아래 텍스트뷰(내용칸)으로 커서 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.titleTextField {
            self.contextTextView.becomeFirstResponder()
        }
        return true
    }
}

extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static var currentResponder: UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func trap() {
        Static.responder = self
    }
}
