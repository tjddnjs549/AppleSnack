//
//  test.swift
//  AppleSnack
//
//  Created by 조규연 on 2023/08/16.
//

import UIKit

class TestViewController: UIViewController {
    func someFunction() {
        // 업데이트 요청을 보내는 메서드
        NotificationCenter.default.post(name: NSNotification.Name("RequestProgressUpdate"), object: nil)
    }
}
