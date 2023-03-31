//
//  UserDefaults+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        
        /// Whether use Dark Mode or not.
        case isUseDarkMode
     
        /// App Apperance Color
        case tintColor
        
        /// User-defined billing categories
        case categorys
    }
    
    /// Reset all settings in UserDefaults
    func resetAllSettings() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
