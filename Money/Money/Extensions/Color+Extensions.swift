//
//  UIColor+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

extension Color: RawRepresentable {
    
    public init?(rawValue: String) {
        
        guard let data = Data(base64Encoded: rawValue) else {
            self = .black
            return
        }
        
        do {
            #if os(iOS)
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            #elseif os(macOS)
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSColor ?? .black
            #endif
            self = Color(color)
        } catch {
            self = .black
        }
    }
    
    public var rawValue: String {
        
        do {
            #if os(iOS)
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            #elseif os(macOS)
            let data = try NSKeyedArchiver.archivedData(withRootObject: NSColor(self), requiringSecureCoding: false) as Data
            #endif
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}

/*
 參考來源：https://medium.com/geekculture/using-appstorage-with-swiftui-colors-and-some-nskeyedarchiver-magic-a38038383c5e
 */
