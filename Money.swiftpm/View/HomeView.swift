//
//  HomeView.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    
    /// 讀取 UserDefaults 內的值，來決定是否使用深色模式
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    
    var body: some View {
        TabView {
            MoneyRecordView()
                .tabItem {
                    Label("記帳一下", sfSymbols: .money)
                }
            SettingsView()
                .tabItem {
                    Label("設定", sfSymbols: .settings)
                }
        }.preferredColorScheme(isUseDarkMode ? .dark : .light)
    }
}
