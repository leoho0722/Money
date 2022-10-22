//
//  AppSettings.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

enum AppForegroundStyle: String, CaseIterable, Identifiable {
    
    case dark = "Dark"
    
    case light = "Light"
    
    var id: Self { self }
}
