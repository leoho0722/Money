//
//  DetailMoneyRecordView.swift
//  Money
//
//  Created by Leo Ho on 2023/1/21.
//

import SwiftUI

struct DetailMoneyRecordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) private var dismiss
        
    /// 現在是否為編輯模式
    @State private var isEditMode: EditMode = .inactive
    
    @ObservedObject var moneyRecord: FetchedResults<MoneyRecord>.Element
    
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
    
    var body: some View {
        VStack {
            if isEditMode == .active {
                buildEditForm()
            } else {
                buildNormalForm()
            }
        }
        .navigationTitle(Text(isEditMode == .active ? "Edit" : "Detail"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            buildEditButton()
        }
        .onAppear {
            selectedIndex = Int(moneyRecord.recordType!)!
            selectedDate = Date(timestamp: moneyRecord.updateTimestamp)
            selectedCategory = Int(moneyRecord.itemName!)!
            inputPrice = moneyRecord.itemPrice!
            inputNotes = moneyRecord.notes!
        }
        .closeKeyboard()
    }
}

// MARK: - @ViewBuilder

extension DetailMoneyRecordView {
    
    @ViewBuilder private func buildEditButton() -> some View {
        Button {
            if isEditMode.isEditing {
                // 將編輯後的資料更新回 CoreData 內
                moneyRecord.recordType = "\(selectedIndex)"
                moneyRecord.createdAt = selectedDate.toString()
                moneyRecord.updateTimestamp = Int64(selectedDate.timeIntervalSince1970)
                moneyRecord.itemName = "\(selectedCategory)"
                moneyRecord.itemPrice = inputPrice
                moneyRecord.notes = inputNotes
                
                if viewContext.hasChanges {
                    do {
                        try viewContext.save()
                        print("更新記帳成功！")
                    } catch {
                        print("更新記帳失敗，Error：\(error.localizedDescription)")
                    }
                    dismiss()
                }
            } else {
                switch isEditMode {
                case .inactive:
                    self.isEditMode = .active
                case .active:
                    self.isEditMode = .inactive
                default:
                    break
                }
            }
        } label: {
            Text(isEditMode.isEditing ? "Update" : "Edit")
        }
    }
    
    /// 建構一般模式下的表單
    @ViewBuilder private func buildNormalForm() -> some View {
        Form {
            Label("Type：\(AppDefine.RecordType.allCases[selectedIndex].title)", icon: .money)
                .padding(5)
            
            Label("Date：\(moneyRecord.createdAt!)", icon: .calender)
                .padding(5)
            
            Label("Category：\(AppDefine.Category.allCases[selectedCategory].title)", icon: .menucard)
                .padding(5)
            
            Label("Price：\(inputPrice)", icon: .money)
                .padding(5)
            
            Label("Notes：\(inputNotes)", icon: .notes)
                .padding(5)
        }
    }
    
    /// 建構編輯模式下的表單
    @ViewBuilder private func buildEditForm() -> some View {
        Form {
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
            
            DatePicker(selection: $selectedDate,
                       in: ...Date(),
                       displayedComponents: .date) { Label("Date", icon: .calender) }
                .environment(\.locale, Locale.preferredLocale)
                .onChange(of: selectedDate) { newValue in
                    selectedDate = newValue
                }
            
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
            
            HStack {
                Label("Price", icon: .money)
                TextField("", text: $inputPrice, prompt: Text("Input Price"))
                    .padding(.leading)
                    .keyboardType(.numberPad)
                    .onChange(of: inputPrice) { newValue in
                        inputPrice = newValue
                    }
            }
            
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
    }
}
