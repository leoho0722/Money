//
//  SettingsView.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct SettingsView: View {
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    
    @AppStorage(.tintColor) private var tintColor: Color = .accentColor
    
    @AppStorage(.locale) private var locale: String = AppDefine.Locale.zh.rawValue
    
    var body: some View {
        NavigationStack {
            Form {
                Section("顯示") {
                    Picker(selection: $locale) {
                        ForEach(AppDefine.Locale.allCases) { locale in
                            Text(locale.title)
                        }
                    } label: {
                        Label("語系", sfSymbols: .calender)
                    }
                }
                
                Section("外觀") {
                    Toggle(isOn: $isUseDarkMode) {
                        Label("深色模式", sfSymbols: .moon)
                    }
                    ColorPicker(selection: $tintColor) {
                        Label("App 主題色", sfSymbols: .paintpalette)
                    }
                }
            }
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
