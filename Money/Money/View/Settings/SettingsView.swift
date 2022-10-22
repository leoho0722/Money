//
//  SettingsView.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.dataSource.options) { options in
                    Section(options.sectionName) {
                        ForEach(options.content) { content in
                            NavigationLink {
                                SettingsForegroundStyleView(selectedThemeColor: AppStorageManager.shared.themeColor,
                                                            selectedForegroundStyle: .light)
                            } label: {
                                SettingsRow(title: content.title, content: content.content)
                            }
                        }
                    }
                }
            }
            .navigationTitle(transalte(key: .Settings))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
