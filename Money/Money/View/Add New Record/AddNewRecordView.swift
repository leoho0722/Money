//
//  AddNewRecordView.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct AddNewRecordView: View {
    
    /// 使用者選擇的記帳類型 Index
    @State var selectedIndex: Int = 0
    
    /// 使用者選擇的日期
    @State var selectedDate: Date = .now
    
    /// 使用者輸入的金額
    @State var inputText: String = ""
    
    /// 使用者輸入的補充內容
    @State var inputNotes: String = ""
    
    /// 使用者選擇的類別 Index
    @State var selectedCategory: Int = 0
    
    /// 使用者選擇的帳戶 Index
    @State var selectedAccount: Int = 0
    
    /// 是否顯示 Alert
    @State var isPresented: Bool = false
    
    /// Alert 要顯示的 Title
    private var alertTitle: String {
        if inputText.isEmpty {
            return transalte(key: .AmountHasNotBeenEntered)
        } else {
            return transalte(key: .SaveSucceed)
        }
    }
    
    private var viewModel = AddNewRecordViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - 支出／收入 Picker
                Picker(transalte(key: .RecordType), selection: $selectedIndex) {
                    ForEach(viewModel.recordTypeList) { recordType in
                        Text(recordType.name).tag(recordType.tag)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedIndex) { newValue in
                    selectedIndex = newValue
                }
                
                // MARK: - 記帳日期 DatePicker
                DatePicker(transalte(key: .Today),
                           selection: $selectedDate,
                           in: ...Date(),
                           displayedComponents: .date)
                .onChange(of: selectedDate) { newValue in
                    selectedDate = newValue
                }
                
                // MARK: - 金額 TextField
                AddNewRecordTextFieldRow(text: $inputText)
                    .onSubmit {
                        print(inputText)
                    }
                
                // MARK: - 類別 Menu
                HStack {
                    Image(systemName: "menucard.fill")
                    Spacer()
                    Picker(transalte(key: .Category), selection: $selectedCategory) {
                        ForEach(viewModel.categoryList) { category in
                            Text(category.name).tag(category.tag)
                        }
                    }
                    .onChange(of: selectedCategory, perform: { newValue in
                        selectedCategory = newValue
                    })
                    .pickerStyle(.menu)
                }
                
                // MARK: - 帳戶 Menu
                HStack {
                    Image(systemName: "dollarsign.circle")
                    Spacer()
                    Picker(transalte(key: .Account), selection: $selectedAccount) {
                        ForEach(viewModel.accountList) { account in
                            Text(account.name).tag(account.tag)
                        }
                    }
                    .onChange(of: selectedAccount, perform: { newValue in
                        selectedAccount = newValue
                    })
                    .pickerStyle(.menu)
                }
                
                // MARK: - 該筆記帳的補充內容 TextEditor
                VStack(alignment: .leading) {
                    Text(transalte(key: .NotesSomething))
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
            .modifier(CloseKeyboard()) // 點空白處關鍵盤
            .navigationTitle(transalte(key: .NewRecord))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        isPresented.toggle()
                        
                        print("記帳類型：\(viewModel.recordTypeList[selectedIndex].name)")
                        print("記帳日期：\(selectedDate)")
                        print("金額：\(inputText)")
                        print("類別：\(viewModel.categoryList[selectedCategory].name)")
                        print("帳戶：\(viewModel.accountList[selectedAccount].name)")
                        print("補充內容：\(inputNotes)\n")
                    } label: {
                        Image(systemName: "plus")
                    }
                    .alert(Text(alertTitle), isPresented: $isPresented) {
                        Button(transalte(key: .Close)) {
                            //
                        }
                    }
                }
            }
        }
    }
}

struct AddNewRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewRecordView()
    }
}

/*
 參考來源：https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui
 */
struct CloseKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
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
