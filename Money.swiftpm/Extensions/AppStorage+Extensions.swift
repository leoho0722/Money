//
//  AppStorage+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

extension AppStorage {
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value == Int {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value == Double {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value == URL {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value == Data {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value : RawRepresentable, Value.RawValue == Int {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value,
         _ key: UserDefaults.Keys,
         store: UserDefaults? = nil) where Value : RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
}
