//
//  NewMoneyRecordView.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

@available(iOS 16.0, *)
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
                }
            }
            .navigationTitle(Text("新增記帳"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        if inputPrice.isEmpty || inputNotes.isEmpty {
                            isPresentAlert.toggle()
                        } else {
                            // 將資料存進 CoreData 內
                            let record = MoneyRecord(context: viewContext)
                            record.id = UUID()
                            record.recordType = "\(selectedIndex)" // 該筆記帳紀錄的記帳類型
                            record.createTimestamp = Int64(selectedDate.timeIntervalSince1970) // 該筆記帳紀錄的建立時間戳
                            record.updateTimestamp = Int64(selectedDate.timeIntervalSince1970) // 該筆記帳紀錄的更新時間戳
                            record.itemName = "\(selectedCategory)" // 該筆記帳紀錄的記帳分類
                            record.itemPrice = inputPrice // 該筆記帳紀錄的記帳金額
                            record.notes = inputNotes // 該筆記帳紀錄的記帳備註
                            
                            do {
                                try viewContext.save()
                                print("新增記帳成功！")
                                isPresentBottomSheet.toggle()
                            } catch {
                                print("新增記帳失敗，Error：\(error.localizedDescription)")
                            }
                        }
                    } label: {
                        Text("儲存")
                            .backgroundStyle(.bar)
                    }.alert(Text("警告"), isPresented: $isPresentAlert) {
                        Button("關閉") {
                            //
                        }
                    } message: {
                        Text("尚有資訊沒有填寫")
                    }
                }
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
}
