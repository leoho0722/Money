//
//  AddNewRecordViewModel.swift
//  Money
//
//  Created by Leo Ho on 2022/10/23.
//

import SwiftUI

class AddNewRecordViewModel {
    
    var recordTypeList: [Records] = [
        .init(name: transalte(key: .Expenditure), tag: 0),
        .init(name: transalte(key: .Income), tag: 1)
    ]
    
    var categoryList: [Records] = [
        .init(name: transalte(key: .Meals), tag: 0),
        .init(name: transalte(key: .Traffic), tag: 1),
        .init(name: transalte(key: .Entertainment), tag: 2),
        .init(name: transalte(key: .TelecomCharges), tag: 3),
        .init(name: transalte(key: .WaterBill), tag: 4),
        .init(name: transalte(key: .GasFee), tag: 5)
    ]
    
    var accountList: [Records] = [
        .init(name: transalte(key: .Cash), tag: 0),
        .init(name: transalte(key: .Bank), tag: 1),
        .init(name: transalte(key: .CreditCard), tag: 2)
    ]
}
