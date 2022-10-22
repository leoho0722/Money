//
//  ContentView.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct ContentView: View {
        
    @State var themeColor: Color = AppStorageManager.shared.themeColor

    var body: some View {
        TabView {
            MoneyBookView()
                .tabItem {
                    Label(transalte(key: .MoneyBook), systemImage: "square.and.pencil")
                }
            AddNewRecordView()
                .tabItem {
                    Label(transalte(key: .NewRecord), systemImage: "plus")
                }
            SettingsView()
                .tabItem {
                    Label(transalte(key: .Settings), systemImage: "gear")
                }
        }
        .tint(themeColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(themeColor: AppStorageManager.shared.themeColor)
    }
}
