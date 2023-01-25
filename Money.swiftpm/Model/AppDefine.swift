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
    }
    
    enum RecordType: Int, CaseIterable, Identifiable {
        
        /// 收入
        case income = 0
        
        /// 花費
        case expenditure
        
        var id: Int { self.rawValue }
        
        var title: String {
            switch self {
            case .income:
                return "收入"
            case .expenditure:
                return "支出"
            }
        }
    }
    
    enum Category: Int, CaseIterable, Identifiable {
        
        /// 三餐
        case meals = 0
        
        /// 交通
        case traffic
        
        /// 娛樂
        case entertainment
        
        /// 電信費
        case telecomCharges
        
        /// 水費
        case waterBill
        
        /// 瓦斯費
        case gasFee
        
        var id: Int { self.rawValue }
        
        var title: String {
            switch self {
            case .meals:
                return "三餐"
            case .traffic:
                return "交通"
            case .entertainment:
                return "娛樂"
            case .telecomCharges:
                return "電信費"
            case .waterBill:
                return "水費"
            case .gasFee:
                return "瓦斯費"
            }
        }
    }
}
