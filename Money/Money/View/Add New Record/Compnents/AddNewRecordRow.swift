//
//  AddNewRecordRow.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI
import Combine

struct AddNewRecordRow: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle")
            Spacer()
            Text(transalte(key: .Price))
            Spacer()
            TextField("", text: $text, prompt: Text(transalte(key: .EnterAmount)))
                .padding(.leading)
                .keyboardType(.numbersAndPunctuation)
                .onReceive(Just(text)) { newValue in
                    // 過濾非數字的值
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.text = filtered // 如果輸入的值中有非數字的話，就替換成過濾過後的值
                    }
                }
        }
    }
}

/*
 參考來源：https://stackoverflow.com/questions/58733003/how-to-create-textfield-that-only-accepts-numbers
 */
