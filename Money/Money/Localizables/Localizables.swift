//
//  Localizables.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

enum LocalizationKeys: String {
    
    // MARK: - Alert
    
    case Close = "Close"
    
    // MARK: - Alert Message
    
    // SettingsForegroundStyleView
    case App_appearance_will_change_the_next_time_you_open_it = "App appearance will change the next time you open it."
    case App_theme_color_will_change_the_next_time_you_open_it = "App appearance will change the next time you open it"
    
    // MARK: - TabView
    
    case MoneyBook = "Money Book"
    
    case NewRecord = "New Record"
    
    case Settings = "Settings"
    
    // MARK: - SettingsView
    
    case Dark = "Dark"

    case Light = "Light"
    
    case Appearance = "Appearance"
    
    case AppAppearance = "App Appearance"
    
    case AppTheme = "App Theme"
    
    case AppThemeColor = "App Theme Color"
}

func transalte(key: LocalizationKeys) -> String {
    return NSLocalizedString(key.rawValue, comment: "")
}
