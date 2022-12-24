//
//  MoneyBookView.swift
//  Money
//
//  Created by Leo Ho on 2022/10/22.
//

import SwiftUI

struct MoneyBookView: View {
    
    @State private var selectedDate: Date = Date()
    
    @ObservedObject private var viewModel = MoneyBookViewModel()
    
    var body: some View {
        VStack {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .onChange(of: selectedDate) { newValue in
                    let date = AppUtility.dateFormatter(date: newValue, needFormat: .YYYYMMdd)
                    viewModel.getMoneyData(date: date)
                }
            Spacer()
            
            List {
                ForEach(viewModel.data) { money in
                    Text(money.category)
                }
            }
        }
    }
}

struct MoneyBookView_Previews: PreviewProvider {
    static var previews: some View {
        MoneyBookView()
    }
}
