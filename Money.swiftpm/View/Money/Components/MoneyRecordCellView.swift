//
//  MoneyRecordCellView.swift
//  
//
//  Created by Leo Ho on 2023/1/27.
//

import SwiftUI

struct MoneyRecordCellView: View {
    
    var record: MoneyRecord
    
    var body: some View {
        VStack(alignment: .leading) {
            // 記帳類型
            Label("類型：\(AppDefine.RecordType.allCases[Int(record.recordType)!].title)", sfSymbols: .money)
                .padding(5)

            // 記帳日期
            Label("日期：\(record.createdAt)", sfSymbols: .calender)
                .padding(5)

            // 記帳分類
            Label("分類：\(AppDefine.Category.allCases[Int(record.itemName)!].title)", sfSymbols: .menucard)
                .padding(5)

            // 記帳金額
            Label("金額：\(record.itemPrice)", sfSymbols: .money)
                .padding(5)
        }
    }
}
