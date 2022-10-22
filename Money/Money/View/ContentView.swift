//
//  ContentView.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct ContentView: View {
    
    /// App 主題顏色，根據使用者選擇的顏色來變動
    @State var themeColor: Color = AppStorageManager.shared.themeColor

    var body: some View {
        TabView {
            // MARK: - 帳本頁面
            MoneyBookView()
                .tabItem {
                    Label(transalte(key: .MoneyBook), systemImage: "square.and.pencil")
                }
            // MARK: - 記帳頁面
            AddNewRecordView()
                .tabItem {
                    Label(transalte(key: .NewRecord), systemImage: "plus")
                }
            // MARK: - 設定頁面
            SettingsView()
                .tabItem {
                    Label(transalte(key: .Settings), systemImage: "gear")
                }
        }
        .tint(themeColor) // 設定 App 主題顏色
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
