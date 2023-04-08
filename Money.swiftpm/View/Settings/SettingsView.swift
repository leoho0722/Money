//
//  SettingsView.swift
//  Money
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

struct SettingsView: View {
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: []
    ) private var moneyRecords: FetchedResults<MoneyRecord>
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var laVM: LocalAuthenticationViewModel
    
    @AppStorage(.isUseDarkMode) private var isUseDarkMode: Bool = false
    
    @AppStorage(.isUseLocalAuthentication) private var isUseLocalAuthentication: Bool = false
    
    @AppStorage(.tintColor) private var tintColor: Color = .accentColor
    
    @State private var isPresentedAlert: Bool = false
    @State private var isPresentedResetAllDataAlert: Bool = false
    @State private var isPresentedResetAllUserSettingsAlert: Bool = false
    @State private var isPresentedResetAllAlert: Bool = false
    @State private var isPresentedAboutAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            buildSettingsView()
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.large)
        }.onAppear {
            laVM.getBiometryType()
            print("Device Support Biometry Type：",laVM.deviceSupportBiometryType.rawValue)
        }
    }
}

// MARK: - @ViewBuilder

extension SettingsView {
    
    @ViewBuilder private func buildSettingsView() -> some View {
        Form {
            Section("Appearance") {
                Toggle(isOn: $isUseDarkMode) {
                    Label("Dark Mode", icon: .moon)
                }
                ColorPicker(selection: $tintColor) {
                    Label("Theme Color", icon: .paintpalette)
                }
            }
            
//                Section("Basic") {
//                    NavigationLink {
//                        CategorySettingsList()
//                    } label: {
//                        Label("Accounting Category", sfSymbols: .menucard)
//                    }
//                }
            
            if laVM.deviceSupportBiometryType != .none {
                Section("Authentication") {
                    Toggle(isOn: $isUseLocalAuthentication) {
                        Label("Biometric Authentication", icon: (laVM.deviceSupportBiometryType == .faceID) ? .faceid : .touchid)
                    }
                    .onChange(of: isUseLocalAuthentication) { newValue in
                        print(newValue)
                        let reason = newValue ? "Enable" : "Disable"
                        if newValue {
                            Task {
                                await laVM.authenicate(reason: "\(reason) Biometric Authentication")
                            }
                        }
                    }
                }
            }
            
            Section("Advanced") {
                Button(role: .destructive) {
                    isPresentedAlert.toggle()
                } label: {
                    Label("Reset", icon: .trash)
                        .foregroundColor(.red)
                }
                .confirmationDialog("Reset", isPresented: $isPresentedAlert) {
                    Button("Reset All Data", role: .destructive) {
                        isPresentedResetAllDataAlert.toggle()
                    }
                    Button("Reset All User Settings", role: .destructive) {
                        isPresentedResetAllUserSettingsAlert.toggle()
                    }
                    Button("Reset All", role: .destructive) {
                        isPresentedResetAllAlert.toggle()
                    }
                    
                    Button("Cancel", role: .cancel, action: {})
                } message: {
                    Text("This operation cannot be undo.\n Do you want to continue?")
                        .frame(alignment: .leading)
                }
                .modifier(ResetAllDataModifier(isPresented: $isPresentedResetAllDataAlert, data: moneyRecords))
                .modifier(ResetAllUserSettingsModifier(isPresented: $isPresentedResetAllUserSettingsAlert))
                .modifier(ResetAllModifier(isPresented: $isPresentedResetAllAlert, data: moneyRecords))
            }
            
            Section {
                Button {
                    isPresentedAboutAlert.toggle()
                } label: {
                    Label("About", icon: .info)
                }.alert("About", isPresented: $isPresentedAboutAlert) {
                    Button("Close", action: {})
                } message: {
                    Text("App Version：Swift Student Chanllenge WWDC23")
                }
            }
        }
    }
}

// MARK: -  ViewModifiers

extension SettingsView {
    
    struct ResetAllDataModifier: ViewModifier {
        
        @Binding var isPresented: Bool
        
        let data: FetchedResults<MoneyRecord>
        
        func body(content: Content) -> some View {
            content
                .confirmationDialog("Reset All Data", isPresented: $isPresented) {
                    Button("Confirm", role: .destructive) {
                        PersistenceController.shared.deleteAllData(data: data)
                    }
                    
                    Button("Cancel", role: .cancel, action: {})
                } message: {
                    Text("This operation will clear all data in the App.\n Do you want to continue?")
                        .frame(alignment: .leading)
                }
        }
    }
    
    struct ResetAllUserSettingsModifier: ViewModifier {
        
        @Binding var isPresented: Bool
        
        func body(content: Content) -> some View {
            content
                .confirmationDialog("Reset All User's Settings", isPresented: $isPresented) {
                    Button("Confirm", role: .destructive) {
                        UserDefaults.standard.resetAllSettings()
                    }
                    
                    Button("Cancel", role: .cancel, action: {})
                } message: {
                    Text("This operation will clear all user's settings in the App.\n Do you want to continue?")
                        .frame(alignment: .leading)
                }
        }
    }
    
    struct ResetAllModifier: ViewModifier {
        
        @Binding var isPresented: Bool
        
        let data: FetchedResults<MoneyRecord>
        
        func body(content: Content) -> some View {
            content
                .confirmationDialog("Reset All Data", isPresented: $isPresented) {
                    Button("Confirm", role: .destructive) {
                        UserDefaults.standard.resetAllSettings()
                        PersistenceController.shared.deleteAllData(data: data)
                    }
                    
                    Button("Cancel", role: .cancel, action: {})
                } message: {
                    Text("This operation will clear all data and user's settings in the App.\n Do you want to continue?")
                        .frame(alignment: .leading)
                }
        }
    }
}
