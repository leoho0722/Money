//
//  AppStorageManager.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

class AppStorageManager: NSObject {
    
    static let shared = AppStorageManager()
    
    enum AppStorageValues: String {
        
        /// 是否啟用深色模式，true = 啟用深色模式，false = 啟用淺色模式
        case isEnableDarkMode
        
        /// 整個 App 的外觀顏色
        case foregroundStyle
        
        /// 整個 App 的主題顏色
        case themeColor
    }
    
    @AppStorage(AppStorageValues.isEnableDarkMode.rawValue) var isEnableDarkMode: Bool = false
    @AppStorage(AppStorageValues.foregroundStyle.rawValue) var foregroundStyle: String = AppForegroundStyle.light.rawValue
    @AppStorage(AppStorageValues.themeColor.rawValue) var themeColor: Color = .black
}
