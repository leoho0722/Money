//
//  Records.swift
//  Money
//
//  Created by Leo Ho on 2022/10/23.
//

import SwiftUI

struct Records: Identifiable, Hashable {
    
    var id = UUID().uuidString
    
    var name: String
    
    var tag: Int
}
