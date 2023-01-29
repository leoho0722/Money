//
//  SettingsView.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct SettingsView: View {
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: []
    ) private var moneyRecords: FetchedResults<MoneyRecord>
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    
    @AppStorage(.tintColor) private var tintColor: Color = .accentColor
    
    @State private var isPresentResetAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("外觀") {
                    Toggle(isOn: $isUseDarkMode) {
                        Label("深色模式", sfSymbols: .moon)
                    }
                    ColorPicker(selection: $tintColor) {
                        Label("App 主題色", sfSymbols: .paintpalette)
                    }
                }
                
//                Section("基本設定") {
//                    NavigationLink {
//                        CategorySettingsList()
//                    } label: {
//                        Label("記帳分類", sfSymbols: .menucard)
//                    }
//                }
                
                Section("進階設定") {
                    Button(role: .destructive) {
                        isPresentResetAlert.toggle()
                    } label: {
                        Label("清除所有內容與設定", sfSymbols: .trash)
                            .foregroundColor(.red)
                    }
                    .confirmationDialog("清除所有內容與設定", isPresented: $isPresentResetAlert) {
                        Button("確認", role: .destructive) {
                            UserDefaults.standard.resetAllSettings()
                            
                            PersistenceController.shared.deleteAllData(data: moneyRecords)
                        }
                        
                        Button("取消", role: .cancel, action: {})
                    } message: {
                        Text("此操作將會清除 App 內所有內容與設定\n是否要繼續進行操作？")
                    }
                }
            }
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
