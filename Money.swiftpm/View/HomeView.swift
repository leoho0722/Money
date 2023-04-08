//
//  HomeView.swift
//  Money
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    
    var body: some View {
        TabView {
            MoneyRecordView()
                .tabItem {
                    Label("Records", sfSymbols: .money)
                }
            HistoryChartView()
                .tabItem {
                    Label("Charts", sfSymbols: .chart)
                }
            SettingsView()
                .tabItem {
                    Label("Settings", sfSymbols: .settings)
                }
        }.preferredColorScheme(isUseDarkMode ? .dark : .light)
    }
}
