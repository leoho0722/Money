//
//  View+Extensions.swift
//  Money
//
//  Created by Leo Ho on 2023/4/8.
//

import SwiftUI

extension View {
    
    func closeKeyboard() -> some View {
        ModifiedContent(content: self, modifier: CloseKeyboardModifier())
    }
}
