//
//  HomeView.swift
//  Money
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    
    @EnvironmentObject private var laVM: LocalAuthenticationViewModel
    
    var body: some View {
        TabView {
            MoneyRecordView()
                .tabItem {
                    Label("Records", icon: .money)
                }
            HistoryChartView()
                .tabItem {
                    Label("Charts", icon: .chart)
                }
            SettingsView()
                .tabItem {
                    Label("Settings", icon: .settings)
                }
                .environmentObject(laVM)
        }
        #if targetEnvironment(macCatalyst)
        .frame(minWidth: 500, minHeight: 300)
        #endif
        .preferredColorScheme(isUseDarkMode ? .dark : .light)
    }
}
