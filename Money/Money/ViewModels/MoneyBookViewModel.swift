//
//  MoneyBookViewModel.swift
//  Money
//
//  Created by Leo Ho on 2022/12/23.
//

import Foundation

class MoneyBookViewModel: ObservableObject {
    
    @Published var data: [Money] = [
        .init(type: transalte(key: .Expenditure),
              date: Date(timeIntervalSince1970: 1671889860), // 2022-12-24 21:51:00 GMT+8
              price: "100",
              category: "Meals",
              account: "Cash",
              notes: ""),
        .init(type: transalte(key: .Expenditure),
              date: Date(timeIntervalSince1970: 1671803520), // 2022-12-23 21:52:00 GMT+8
              price: "1000",
              category: "Traffic",
              account: "Cash",
              notes: "")
    ]
    
    func getMoneyData(date: Date) {
        data = data.filter({ $0.date == date })
    }
}
