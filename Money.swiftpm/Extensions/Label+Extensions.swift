//
//  Label+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2023/1/25.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    
    init(_ titleKey: LocalizedStringKey, sfSymbols: AppDefine.SFSymbols) {
        self.init(titleKey, systemImage: sfSymbols.rawValue)
    }
}
