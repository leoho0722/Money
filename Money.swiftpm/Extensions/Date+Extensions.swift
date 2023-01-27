//
//  Date+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/26.
//

import Foundation

extension Date {
    
    init(timestamp: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    /// 將 Date 用 DateFormatter 轉為 YYYY/MM/dd 的日期字串
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: UserDefaults.standard.string(forKey: "locale") ?? "zh")
        formatter.dateFormat = AppDefine.Locale(rawValue: UserDefaults.standard.string(forKey: "locale") ?? "zh")?.dateFormat
        return formatter.string(from: self)
    }
}
