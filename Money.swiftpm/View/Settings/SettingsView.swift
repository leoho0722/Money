//
//  SettingsView.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

@available(iOS 16.0, *)
struct SettingsView: View {
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: []
    ) private var moneyRecords: FetchedResults<MoneyRecord>
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    
    @AppStorage(.tintColor) private var tintColor: Color = .accentColor
    
    @State private var isPresentResetAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Appearance") {
                    Toggle(isOn: $isUseDarkMode) {
                        Label("Dark Mode", sfSymbols: .moon)
                    }
                    ColorPicker(selection: $tintColor) {
                        Label("App Theme Color", sfSymbols: .paintpalette)
                    }
                }
                
//                Section("Basic") {
//                    NavigationLink {
//                        CategorySettingsList()
//                    } label: {
//                        Label("Accounting Category", sfSymbols: .menucard)
//                    }
//                }
                
                Section("Advanced") {
                    Button(role: .destructive) {
                        isPresentResetAlert.toggle()
                    } label: {
                        Label("Reset All content and settings", sfSymbols: .trash)
                            .foregroundColor(.red)
                    }
                    .confirmationDialog("Reset All content and settings", isPresented: $isPresentResetAlert) {
                        Button("Confirm", role: .destructive) {
                            UserDefaults.standard.resetAllSettings()
                            
                            PersistenceController.shared.deleteAllData(data: moneyRecords)
                        }
                        
                        Button("Cancel", role: .cancel, action: {})
                    } message: {
                        Text("This operation will clear all content and settings in the app\nDo you want to proceed?")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
