//
//  CategorySettingsList.swift
//  Money
//
//  Created by Leo Ho on 2023/1/29.
//

import SwiftUI

struct CategorySettingsList: View {
    
    @AppStorage(.categorys) private var categorys: [String] = [
        AppDefine.Category.meals.title,
        AppDefine.Category.traffic.title,
        AppDefine.Category.entertainment.title,
        AppDefine.Category.telecomCharges.title,
        AppDefine.Category.waterBill.title,
        AppDefine.Category.gasFee.title,
    ]
    
    @FocusState private var isFocused: Bool
    
    /// 現在是否為編輯模式
    @State private var isEditMode: EditMode = .inactive
    
    /// 想要新增的新記帳分類
    @State private var newInputCategory: String = ""

    var body: some View {
        VStack {
            buildCategoryView()
        }
        .navigationTitle("Accounting Category")
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            buildAddButton()
        }
    }
}

// MARK: - @ViewBuilder

extension CategorySettingsList {
    
    @ViewBuilder private func buildCategoryView() -> some View {
        Form {
            List {
                ForEach(categorys, id: \.self) { category in
                    Text(category)
                }
                
                if isEditMode == .active {
                    VStack {
                        HStack {
                            Label("New Category", icon: .menucard)
                            TextField("", text: $newInputCategory, prompt: Text("Create New Category"))
                                .padding(.leading)
                                .focused($isFocused)
                                .onSubmit {
                                    print(newInputCategory)
                                    if !newInputCategory.isEmpty {
                                        categorys.append(newInputCategory)
                                        newInputCategory = ""
                                    }
                                }
                        }.padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        
                        Spacer(minLength: 5)
                        
                        Button(role: .cancel) {
                            isEditMode = .inactive
                            isFocused.toggle()
                        } label: {
                            Label("Cancel", icon: .xmark)
                                .padding()
                                .foregroundColor(.white)
                                .background(.red)
                                .cornerRadius(.infinity)
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    @ViewBuilder private func buildAddButton() -> some View {
        Button {
            if isEditMode.isEditing {
                if !newInputCategory.isEmpty {
                    categorys.append(newInputCategory)
                    newInputCategory = ""
                }
            } else {
                switch isEditMode {
                case .inactive:
                    self.isEditMode = .active
                    isFocused.toggle()
                case .active:
                    self.isEditMode = .inactive
                default:
                    break
                }
            }
        } label: {
            Text(isEditMode.isEditing ? "Done" : "Add")
        }
    }
}
