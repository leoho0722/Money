//
//  AppSettings.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

enum AppForegroundStyle: String, CaseIterable, Identifiable {
    
    /// 深色模式／Dark Mode
    case dark = "Dark"
    
    /// 淺色模式／Light Mode
    case light = "Light"
    
    var id: Self { self }
}
