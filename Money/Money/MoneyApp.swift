//
//  MoneyApp.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

@main
struct MoneyApp: App {

    
    var body: some Scene {
        WindowGroup {
            ContentView(themeColor: AppStorageManager.shared.themeColor)
                .environment(\.colorScheme, AppStorageManager.shared.isEnableDarkMode ? .dark : .light)
        }
    }
}
