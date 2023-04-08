//
//  Date+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2023/1/26.
//

import Foundation

extension Date {
    
    init(timestamp: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(timestamp))
    }
    
    /// Convert Date to YYYY/MM/dd date string using DateFormatter
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = .preferredLocale
        formatter.dateFormat = AppDefine.Locale(rawValue: Locale.preferredLocaleToString)?.dateFormat
        return formatter.string(from: self)
    }
}
