//
//  Array+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2023/1/29.
//

import Foundation

extension Array: RawRepresentable where Element: Codable {
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data) else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return result
    }
}

/*
 Reference Source：https://www.fatbobman.com/posts/appstorage/
 */
