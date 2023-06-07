//
//  Image+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

extension Image {
    
    init(icon: SFSymbols) {
        self.init(systemName: icon.rawValue)
    }
}
