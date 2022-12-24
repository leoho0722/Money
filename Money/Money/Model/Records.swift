//
//  Records.swift
//  Money
//
//  Created by Leo Ho on 2022/10/23.
//

import SwiftUI

/// 新增記帳時的畫面結構
struct Records: Identifiable, Hashable {
    
    var id = UUID()
    
    var name: String
    
    var tag: Int
}
