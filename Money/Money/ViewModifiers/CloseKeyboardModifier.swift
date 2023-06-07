//
//  CloseKeyboardModifier.swift
//  Money
//
//  Created by Leo Ho on 2023/4/8.
//

import SwiftUI

struct CloseKeyboardModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
            }
    }
}
