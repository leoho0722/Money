//
//  FilteredList.swift
//  Money
//
//  Created by Leo Ho on 2023/1/27.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View where T: Identifiable {
    
    @FetchRequest var fetchRequest: FetchedResults<T>
        
    /// List 內要顯示的畫面
    let content: (T) -> Content
    
    /// 刪除 List 內資料的 Closure
    let delete: ((IndexSet) -> Void)?
    
    /// FilteredList 初始化
    /// - Parameters:
    ///   - filterKey: 要進行 filter 的 Key
    ///   - filterValue: 要進行 filter 的 Value
    ///   - delete: 執行刪除 List 內資料的 Function
    ///   - content: List 內要顯示的畫面
    init(filterKey: String,
         filterValue: String,
         delete: ((IndexSet) -> Void)?,
         @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest(
            entity: MoneyRecord.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \MoneyRecord.createdAt, ascending: false)
            ],
            predicate: NSPredicate(format: "%K == %@", filterKey, filterValue)
        )
        
        self.content = content
        
        self.delete = delete
    }
    
    var body: some View {
        List {
            ForEach(fetchRequest) { T in
                self.content(T)
            }.onDelete(perform: self.delete)
        }
    }
}

/*
 Reference Source：https://www.hackingwithswift.com/books/ios-swiftui/dynamically-filtering-fetchrequest-with-swiftui
 */
