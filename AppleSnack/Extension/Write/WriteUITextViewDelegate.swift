//
//  WriteUITextViewDelegate.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/20.
//

import UIKit

// MARK: - UITextViewDelegate


extension WriteViewController: UITextViewDelegate {
    
    //텍스트뷰 플레이스 홀더
    // 입력을 시작할때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "내용을 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "내용을 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
