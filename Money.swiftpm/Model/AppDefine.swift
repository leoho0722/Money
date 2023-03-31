//
//  AppDefine.swift
//  
//
//  Created by Leo Ho on 2023/1/20.
//

import SwiftUI

struct AppDefine {
    
    /// enum SF Symbols icon
    enum SFSymbols: String {
        
        /// SF Symbols icon name：menucard.fill
        case menucard = "menucard.fill"
        
        /// SF Symbols icon name：dollarsign.circle.fill
        case money = "dollarsign.circle.fill"
        
        /// SF Symbols icon name：gear.circle.fill
        case settings = "gear.circle.fill"
        
        /// SF Symbols icon name：plus.circle.fill
        case plus = "plus.circle.fill"
        
        /// SF Symbols icon name：moon.circle.fill
        case moon = "moon.circle.fill"
        
        /// SF Symbols icon name：calendar.circle.fill
        case calender = "calendar.circle.fill"
        
        /// SF Symbols icon name：note.text
        case notes = "note.text"
        
        /// SF Symbols icon name：paintpalette.fill
        case paintpalette = "paintpalette.fill"
        
        /// SF Symbols icon name：trash.circle.fill
        case trash = "trash.circle.fill"
        
        /// SF Symbols icon name：chart.line.uptrend.xyaxis.circle.fill
        case chart = "chart.line.uptrend.xyaxis.circle.fill"
        
        /// SF Symbols icon name：line.3.horizontal.decrease.circle.fill
        case filter = "line.3.horizontal.decrease.circle.fill"
        
        /// SF Symbols icon name：xmark.seal.fill
        case xmark = "xmark.seal.fill"
    }
    
    /// enum 記帳類型
    enum RecordType: Int, CaseIterable, Identifiable {
        
        /// 收入
        case income = 0
        
        /// 花費
        case expenditure
        
        var id: Int { self.rawValue }
        
        var title: String {
            switch self {
            case .income:
                return "Income"
            case .expenditure:
                return "Expenditure"
            }
        }
    }
    
    /// enum 記帳種類
    enum Category: Int, CaseIterable, Identifiable {
        
        /// Meals
        case meals = 0
        
        /// Traffic
        case traffic
        
        /// Entertainment
        case entertainment
        
        /// Telecom Charges
        case telecomCharges
        
        /// Water Bill
        case waterBill
        
        /// Gas Fee
        case gasFee
        
        var id: Int { self.rawValue }
        
        var title: String {
            switch self {
            case .meals:
                return "Meals"
            case .traffic:
                return "Traffic"
            case .entertainment:
                return "Entertainment"
            case .telecomCharges:
                return "Telecom Charges"
            case .waterBill:
                return "Water Bill"
            case .gasFee:
                return "Gas Fee"
            }
        }
    }
    
    /// enum 顯示語系
    enum Locale: String, CaseIterable, Identifiable {
        
        /// 中文
        case zh
        
        /// 英文
        case en
        
        /// 韓文
        case ko
        
        var id: String { self.rawValue }
        
        var title: String {
            switch self {
            case .zh:
                return "繁體／簡體中文"
            case .en:
                return "English"
            case .ko:
                return "한국어"
            }
        }
        
        var dateFormat: String {
            switch self {
            case .zh:
                return "YYYY年MM月dd日"
            case .en:
                return "MMM dd, YYYY"
            case .ko:
                return "YYYY. M. dd."
            }
        }
    }
}
