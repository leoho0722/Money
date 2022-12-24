//
//  Money.swift
//  Money
//
//  Created by Leo Ho on 2022/12/23.
//

import SwiftUI

struct Money: Identifiable {
    
    /// 每筆記帳資料的 ID
    var id = UUID()
    
    /// 每筆記帳資料的類型，收入／支出
    var type: String
    
    /// 每筆記帳資料的日期
    var date: Date
    
    /// 每筆記帳資料的金額
    var price: String
    
    /// 每筆記帳資料的分類
    var category: String
    
    /// 每筆記帳資料的帳戶
    var account: String
    
    /// 每筆記帳資料的備註
    var notes: String
}
