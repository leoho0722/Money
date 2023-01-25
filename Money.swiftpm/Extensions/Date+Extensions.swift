//
//  Date+Extensions.swift
//  
//
//  Created by Leo Ho on 2023/1/26.
//

import Foundation

extension Date {
    
    init(timestamp: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(timestamp))
    }
}
