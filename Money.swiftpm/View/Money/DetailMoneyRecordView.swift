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
        Form {
            Picker("類型", selection: $selectedIndex) {
                ForEach(AppDefine.RecordType.allCases) { recordType in
                    Text(recordType.title).tag(recordType.rawValue)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedIndex) { newValue in
                selectedIndex = newValue
            }
            
            DatePicker("今天",
                       selection: $selectedDate,
                       in: ...Date(),
                       displayedComponents: .date)
            .onChange(of: selectedDate) { newValue in
                selectedDate = newValue
            }
            
            HStack {
                Image(sfSymbols: .menucard)
                Spacer()
                Picker("分類", selection: $selectedCategory) {
                    ForEach(AppDefine.Category.allCases) { category in
                        Text(category.title).tag(category.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: selectedCategory) { newValue in
                    selectedCategory = newValue
                }
            }
            
            HStack {
                Image(sfSymbols: .money)
                Spacer()
                Text("金額")
                Spacer()
                TextField("", text: $inputPrice, prompt: Text("輸入金額"))
                    .padding(.leading)
                    .keyboardType(.numberPad)
                    .onChange(of: inputPrice) { newValue in
                        inputPrice = newValue
                    }
            }
            
            VStack(alignment: .leading) {
                Text("備註一下...")
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 5))
                
                TextEditor(text: $inputNotes)
                    .frame(minHeight: 200)
                    .lineSpacing(10) // 行距
                    .autocorrectionDisabled(true) // 關閉自動校正
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    ) // 加上灰色邊框
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                    .onChange(of: inputNotes) { newValue in
                        inputNotes = newValue
                    }
            }
        }
        .navigationTitle(Text("編輯記帳"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup {
                Button {
                    // 將編輯後的資料更新回 CoreData 內
                    moneyRecord.recordType = "\(selectedIndex)"
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
                } label: {
                    Text("更新")
                }
            }
        }
        .onAppear {
            selectedIndex = Int(moneyRecord.recordType)!
            selectedDate = Date(timeIntervalSince1970: TimeInterval(moneyRecord.createTimestamp))
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
}
