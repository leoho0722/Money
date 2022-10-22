//
//  SettingsRow.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct SettingsRow: View {
    
    var title: String
    
    var content: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading)
            Spacer()
            Text(content)
                .padding(.trailing)
        }
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(title: "顏色", content: "粉色")
    }
}
