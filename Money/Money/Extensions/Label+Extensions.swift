//
//  Label+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2022/12/23.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    
    init<S>(_ title: S, sfSymbols: SFSymbols) where S: StringProtocol {
        self.init(title, systemImage: sfSymbols.rawValue)
    }
}
