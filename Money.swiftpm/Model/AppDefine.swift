//
//  AppDefine.swift
//  Money
//
//  Created by Leo Ho on 2023/1/20.
//

import SwiftUI

struct AppDefine {
    
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
                return "Chinese"
            case .en:
                return "English"
            case .ko:
                return "Korean"
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
