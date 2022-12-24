//
//  Image+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2022/12/23.
//

import SwiftUI

extension Image {
    
    init(sfSymbols: SFSymbols) {
        self.init(systemName: sfSymbols.rawValue)
    }
}
