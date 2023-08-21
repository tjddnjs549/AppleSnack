//
//  AppNavigationBarAppearance.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/19.
//

import UIKit

final class AppNavigationBarAppearance: UIViewController {
    
    static func navigationBarSetting() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        
        
        navigationBarAppearance.backgroundColor = .white //배경색 조정
        UINavigationBar.appearance().tintColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00) //아이템색 변경
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00),NSAttributedString.Key.font: UIFont(name: "NotoSansKR-Bold", size: 18)!]
        
        navigationBarAppearance.titleTextAttributes = attributes
        
        navigationBarAppearance.shadowColor = .none

        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
