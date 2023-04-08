//
//  NewMoneyRecordView.swift
//  Money
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

struct NewMoneyRecordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
        
    /// 使用者選擇的記帳類型 Index
    @State private var selectedIndex: Int = 0
    
    /// 使用者選擇的日期
    @State private var selectedDate: Date = .now
    
    /// 使用者選擇的類別 Index
    @State private var selectedCategory: Int = 0
    
    /// 使用者輸入的金額
    @State private var inputPrice: String = ""
    
    /// 使用者輸入的補充內容
    @State private var inputNotes: String = ""
    
    /// 判斷是否顯示 Alert
    @State private var isPresentAlert: Bool = false
    
    /// 判斷是否顯示 BottomSheet
    @Binding var isPresentBottomSheet: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                buildRecordTypePicker()
                buildDatePicker()
                buildCategoryPicker()
                buildPrice()
                buildNotes()
            }
            .navigationTitle(Text("Add Record"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                buildSaveButton()
            }.closeKeyboard()
        }
    }
}

// MARK: - @ViewBuilder

extension NewMoneyRecordView {
    
    @ViewBuilder private func buildRecordTypePicker() -> some View {
        Picker(selection: $selectedIndex) {
            ForEach(AppDefine.RecordType.allCases) { recordType in
                Text(recordType.title).tag(recordType.rawValue)
            }
        } label: {
            Label("Type", icon: .money)
        }
        .pickerStyle(.menu)
        .onChange(of: selectedIndex) { newValue in
            selectedIndex = newValue
        }
    }
    
    @ViewBuilder private func buildDatePicker() -> some View {
        DatePicker(selection: $selectedDate,
                   in: ...Date(),
                   displayedComponents: .date) { Label("Date", icon: .calender) }
            .environment(\.locale, Locale.preferredLocale)
            .onChange(of: selectedDate) { newValue in
                selectedDate = newValue
            }
    }
    
    @ViewBuilder private func buildCategoryPicker() -> some View {
        Picker(selection: $selectedCategory) {
            ForEach(AppDefine.Category.allCases) { category in
                Text(category.title).tag(category.rawValue)
            }
        } label: {
            Label("Category", icon: .menucard)
        }
        .pickerStyle(.menu)
        .onChange(of: selectedCategory) { newValue in
            selectedCategory = newValue
        }
    }
    
    @ViewBuilder private func buildPrice() -> some View {
        HStack {
            Label("Price", icon: .money)
            TextField("", text: $inputPrice, prompt: Text("Input price"))
                .padding(.leading)
                .keyboardType(.numberPad)
        }
    }
    
    @ViewBuilder private func buildNotes() -> some View {
        VStack(alignment: .leading) {
            Label("Note...", icon: .notes)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            TextEditor(text: $inputNotes)
                .frame(minHeight: 200)
                .lineSpacing(10) // 行距
                .autocorrectionDisabled(true) // 關閉自動校正
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray, lineWidth: 1)
                ) // 加上灰色邊框
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
        }
    }
    
    @ViewBuilder private func buildSaveButton() -> some View {
        Button {
            if inputPrice.isEmpty || inputNotes.isEmpty {
                isPresentAlert.toggle()
            } else {
                // 將資料存進 CoreData 內
                let record = MoneyRecord(context: viewContext)
                record.id = UUID()
                record.recordType = "\(selectedIndex)" // 該筆記帳的類型
                record.createdAt = selectedDate.toString() // 該筆記帳的紀錄時間字串
                record.createTimestamp = Int64(selectedDate.timeIntervalSince1970) // 該筆記帳的建立時間戳
                record.updateTimestamp = Int64(selectedDate.timeIntervalSince1970) // 該筆記帳的更新時間戳
                record.itemName = "\(selectedCategory)" // 該筆記帳的記帳分類
                record.itemPrice = inputPrice // 該筆記帳的金額
                record.notes = inputNotes // 該筆記帳的備註

                do {
                    try viewContext.save()
                    print("新增記帳成功！")
                    isPresentBottomSheet.toggle()
                } catch {
                    print("新增記帳失敗，Error：\(error.localizedDescription)")
                }
            }
        } label: {
            Text("Save")
        }.alert(Text("Warnings"), isPresented: $isPresentAlert) {
            Button("Close") {}
        } message: {
            Text("There is still information not filled")
        }
    }
}
