//
//  MoneyApp.swift
//  Money
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

@main
struct MoneyApp: App {
    
    let persistenceController = PersistenceController.shared
    
    /// 讀取 UserDefaults 內的值，來決定 App 外觀顏色
    @AppStorage(.tintColor) private var tintColor: Color = .accentColor
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tint(tintColor)
        }
    }
}
