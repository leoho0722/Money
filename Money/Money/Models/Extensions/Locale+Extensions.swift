//
//  Locale+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2023/1/27.
//

import Foundation

extension Locale {
    
    /// User's preferred display language
    static var preferredLocale: Self {
        return Locale(identifier: String(self.preferredLanguages[0].prefix(2)))
    }
    
    /// Display language conversion string for user preference
    static var preferredLocaleToString: String {
        return String(self.preferredLanguages[0].prefix(2))
    }
}
