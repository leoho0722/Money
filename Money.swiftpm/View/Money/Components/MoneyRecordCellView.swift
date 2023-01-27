//
//  MoneyRecordCellView.swift
//  
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
            Label("類型：\(AppDefine.RecordType.allCases[Int(record.recordType) ?? 0].title)", sfSymbols: .money)
                .padding(5)

            // 記帳日期
            Label("日期：\(record.createdAt)", sfSymbols: .calender)
                .padding(5)

            // 記帳分類
            Label("分類：\(AppDefine.Category.allCases[Int(record.itemName) ?? 0].title)", sfSymbols: .menucard)
                .padding(5)

            // 記帳金額
            Label("金額：\(record.itemPrice)", sfSymbols: .money)
                .padding(5)
        }
    }
}
