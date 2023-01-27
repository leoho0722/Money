//
//  Locale+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/27.
//

import Foundation

extension Locale {
    
    /// 使用者偏好的顯示語系
    static var preferredLocale: Self {
        return Locale(identifier: String(self.preferredLanguages[0].prefix(2)))
    }
    
    /// 使用者偏好的顯示語系轉字串
    static var preferredLocaleToString: String {
        return String(self.preferredLanguages[0].prefix(2))
    }
}
