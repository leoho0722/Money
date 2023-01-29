//
//  UserDefaults+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        
        /// 是否使用深色模式
        case isUseDarkMode
     
        /// App 外觀顏色
        case tintColor
        
        /// 使用者設定的記帳分類
        case categorys
    }
    
    /// 將 UserDefaults 內的值全部重設
    func resetAllSettings() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
