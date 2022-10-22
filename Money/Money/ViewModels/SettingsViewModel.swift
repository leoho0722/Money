//
//  SettingsViewModel.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

class SettingsViewModel {
    
    var dataSource = Settings(options: [
        // Section 1 - 外觀
        SettingsOptions(sectionName: transalte(key: .Appearance), content: [
            SettingsContent(title: transalte(key: .Appearance), content: ""),
        ])
        // Section 2 - 
    ])
}
