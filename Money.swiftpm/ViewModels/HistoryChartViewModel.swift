//
//  HistoryChartViewModel.swift
//  
//
//  Created by Leo Ho on 2023/1/29.
//

import SwiftUI

class HistoryChartViewModel: ObservableObject {
    
    /// 總收入金額
    @Published var totalIncomePrice: Int = 0
    
    /// 總支出金額
    @Published var totalExpenditurePrice: Int = 0
    
    /// 存放 `收入` 的資料
    @Published var incomeData: [Record] = []
    
    /// 存放 `支出` 的資料
    @Published var expenditureData: [Record] = []
}

struct Record: Identifiable {
    
    let id = UUID()
    
    let name: String
    
    let price: Int
}
