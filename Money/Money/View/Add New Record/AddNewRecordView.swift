//
//  AddNewRecordView.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct AddNewRecordView: View {
    
    /// 使用者選擇的類型 Index
    @State var selectedIndex: Int = 0
    
    /// 使用者選擇的日期
    @State var selectedDate: Date = .now
    
    /// 使用者輸入的金額
    @State var inputText: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Picker(transalte(key: .RecordType), selection: $selectedIndex) {
                    Text(transalte(key: .Expenditure)).tag(0)
                    Text(transalte(key: .Income)).tag(1)
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedIndex) { newValue in
                    selectedIndex = newValue
                }
                
                DatePicker(transalte(key: .Today),
                           selection: $selectedDate,
                           in: ...Date(),
                           displayedComponents: .date)
                .onChange(of: selectedDate) { newValue in
                    selectedDate = newValue
                }
                
                AddNewRecordRow(text: $inputText)
                    .onSubmit {
                        print(inputText)
                    }
            }
            .navigationTitle(transalte(key: .NewRecord))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddNewRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewRecordView()
    }
}
