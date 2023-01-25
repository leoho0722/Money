//
//  Image+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

extension Image {
    
    init(sfSymbols: AppDefine.SFSymbols) {
        self.init(systemName: sfSymbols.rawValue)
    }
}
