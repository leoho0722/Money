//
//  AppUtility.swift
//  Money
//
//  Created by Leo Ho on 2022/12/24.
//

import Foundation

struct AppUtility {
    
    enum DateFormat: String {
        /// `YYYY/MM/dd`
        case YYYYMMdd = "YYYY/MM/dd"
    }
    
    static func dateFormatter(date: Date, needFormat: DateFormat) -> Date {
        let locale = Locale.current.identifier
        
        let needFormatter = DateFormatter()
        needFormatter.dateFormat = needFormat.rawValue
        needFormatter.locale = Locale(identifier: locale)
        
        let dateStr = needFormatter.string(from: date)
        
        let date = needFormatter.date(from: dateStr)!
        
        return date
    }
}
