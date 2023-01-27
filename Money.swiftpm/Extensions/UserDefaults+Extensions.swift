//
//  UserDefaults+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String {
        
        /// 是否使用深色模式
        case isUseDarkMode
     
        /// App 外觀顏色
        case tintColor
        
        /// 顯示語系
        case locale
    }
}
