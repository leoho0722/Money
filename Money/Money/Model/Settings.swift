//
//  Settings.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

/// Settings 內要顯示的東西
struct Settings {
    
    var options: [SettingsOptions]
}

/// Settings 內一個 Section 要顯示的東西
struct SettingsOptions: Identifiable {
    
    var id = UUID().uuidString
    
    var sectionName: String
    
    var content: [SettingsContent]
}

/// Settings 內 Row 要顯示的東西
struct SettingsContent: Identifiable {
    
    var id = UUID().uuidString
    
    var title: String
    
    var content: String
}
