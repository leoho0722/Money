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
    
    @StateObject private var laVM = LocalAuthenticationViewModel()
    
    @AppStorage(.isUseLocalAuthentication) private var isUseLocalAuthentication: Bool = false
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(laVM)
                .tint(tintColor)
                .onChange(of: scenePhase) { newValue in
                    switch newValue {
                    case .background:
                        print("App 進背景")
                        laVM.isAppLocked = true
                    case .inactive:
                        print("App inactive")
                    case .active:
                        print("App 回前景")
                        if laVM.isAppLocked {
                            if isUseLocalAuthentication {
                                Task {
                                    laVM.isAppLocked =  await !laVM.authenicate(reason: "Unlock App")
                                }
                            } else {
                                laVM.isAppLocked = false
                            }
                        }
                    @unknown default:
                        print("App unknown scenePhase")
                    }
                }
        }
    }
}
