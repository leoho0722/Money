//
//  MoneyRecordCellView.swift
//  Money
//
//  Created by Leo Ho on 2023/1/27.
//

import SwiftUI

struct MoneyRecordCellView: View {
    
    // NSManagedObject 原生繼承 @ObservedObject，當資料有變動的時候，可以進行監聽並修改成最新的
    @ObservedObject var record: MoneyRecord
    
    var body: some View {
        VStack(alignment: .leading) {
            // 記帳類型
            Label("Type：\(AppDefine.RecordType.allCases[Int(record.recordType!)!].title)", icon: .money)
                .padding(5)

            // 記帳日期
            Label("Date：\(record.createdAt!)", icon: .calender)
                .padding(5)

            // 記帳分類
            Label("Category：\(AppDefine.Category.allCases[Int(record.itemName!)!].title)", icon: .menucard)
                .padding(5)

            // 記帳金額
            Label("Price：\(record.itemPrice!)", icon: .money)
                .padding(5)
        }
    }
}
