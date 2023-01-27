//
//  DetailMoneyRecordView.swift
//  
//
//  Created by Leo Ho on 2023/1/21.
//

import SwiftUI

@available(iOS 16.0, *)
struct DetailMoneyRecordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage(.locale) private var locale: String = AppDefine.Locale.zh.rawValue
    
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
        .navigationTitle(Text(isEditMode == .active ? "編輯記帳" : "詳細記帳內容"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
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
                Text(isEditMode.isEditing ? "更新" : "編輯")
            }
        }
        .onAppear {
            selectedIndex = Int(moneyRecord.recordType)!
            selectedDate = Date(timestamp: moneyRecord.updateTimestamp)
            selectedCategory = Int(moneyRecord.itemName)!
            inputPrice = moneyRecord.itemPrice
            inputNotes = moneyRecord.notes
        }
        .onTapGesture {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            keyWindow?.endEditing(true)
        }
    }
    
    /// 建構一般模式下的表單
    @ViewBuilder private func buildNormalForm() -> some View {
        Form {
            Label("類型：\(AppDefine.RecordType.allCases[selectedIndex].title)", sfSymbols: .money)
                .padding(5)
            
            Label("日期：\(moneyRecord.createdAt)", sfSymbols: .calender)
                .padding(5)
            
            Label("分類：\(AppDefine.Category.allCases[selectedCategory].title)", sfSymbols: .menucard)
                .padding(5)
            
            Label("金額：\(inputPrice)", sfSymbols: .money)
                .padding(5)
            
            Label("備註：\(inputNotes)", sfSymbols: .notes)
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
                Label("類型", sfSymbols: .money)
            }
            .pickerStyle(.menu)
            .onChange(of: selectedIndex) { newValue in
                selectedIndex = newValue
            }
            
            DatePicker(selection: $selectedDate,
                       in: ...Date(),
                       displayedComponents: .date) { Label("日期", sfSymbols: .calender) }
                .environment(\.locale, Locale(identifier: locale))
                .onChange(of: selectedDate) { newValue in
                    selectedDate = newValue
                }
            
            Picker(selection: $selectedCategory) {
                ForEach(AppDefine.Category.allCases) { category in
                    Text(category.title).tag(category.rawValue)
                }
            } label: {
                Label("分類", sfSymbols: .menucard)
            }
            .pickerStyle(.menu)
            .onChange(of: selectedCategory) { newValue in
                selectedCategory = newValue
            }
            
            HStack {
                Label("金額", sfSymbols: .money)
                TextField("", text: $inputPrice, prompt: Text("輸入金額"))
                    .padding(.leading)
                    .keyboardType(.numberPad)
                    .onChange(of: inputPrice) { newValue in
                        inputPrice = newValue
                    }
            }
            
            VStack(alignment: .leading) {
                Label("備註一下...", sfSymbols: .notes)
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
