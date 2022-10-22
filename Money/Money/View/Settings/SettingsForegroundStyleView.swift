//
//  SettingsForegroundStyleView.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct SettingsForegroundStyleView: View {
    
    @State var selectedThemeColor: Color
    
    @State var selectedForegroundStyle: AppForegroundStyle
    
    var body: some View {
        List {
            Section {
                Picker(transalte(key: .Appearance), selection: $selectedForegroundStyle) {
                    ForEach(AppForegroundStyle.allCases) { style in
                        Text(transalte(key: LocalizationKeys(rawValue: style.rawValue)!))
                    }
                }
                .pickerStyle(.navigationLink)
                .onChange(of: selectedForegroundStyle) { newValue in
                    if newValue.rawValue != AppStorageManager.shared.foregroundStyle {
                        print("外觀選擇使用 \(newValue.rawValue) 模式")
                        AppStorageManager.shared.foregroundStyle = newValue.rawValue
                        switch newValue {
                        case .dark:
                            AppStorageManager.shared.isEnableDarkMode = true
                        case .light:
                            AppStorageManager.shared.isEnableDarkMode = false
                        }
                    }
                }
            } header: {
                Text(transalte(key: .AppAppearance))
            } footer: {
                Text(transalte(key: .App_appearance_will_change_the_next_time_you_open_it))
            }
            
            Section {
                ColorPicker(transalte(key: .AppThemeColor), selection: $selectedThemeColor)
                    .onChange(of: selectedThemeColor) { newValue in
                        if newValue != AppStorageManager.shared.themeColor {
                            print("主題顏色選擇使用 \(newValue)")
                            AppStorageManager.shared.themeColor = newValue
                        }
                    }
            } header: {
                Text(transalte(key: .AppTheme))
            } footer: {
                Text(transalte(key: .App_theme_color_will_change_the_next_time_you_open_it))
            }
        }.onAppear(perform: {
            setup()
        })
        .navigationTitle(transalte(key: .Appearance))
    }
    
    func setup() {
        switch AppStorageManager.shared.foregroundStyle {
        case transalte(key: .Dark):
            selectedForegroundStyle = .dark
            AppStorageManager.shared.isEnableDarkMode = true
        case transalte(key: .Light):
            selectedForegroundStyle = .light
            AppStorageManager.shared.isEnableDarkMode = false
        default:
            selectedForegroundStyle = .light
            AppStorageManager.shared.isEnableDarkMode = false
        }
        
        selectedThemeColor = AppStorageManager.shared.themeColor
    }
}

struct SettingsForegroundStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsForegroundStyleView(selectedThemeColor: .red, selectedForegroundStyle: .light)
    }
}
