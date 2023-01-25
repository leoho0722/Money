//
//  MoneyRecord.swift
//  
//
//  Created by Leo Ho on 2023/1/20.
//

import SwiftUI
import CoreData

@objc(MoneyRecord)
class MoneyRecord: NSManagedObject, Identifiable {
    
    /// 該筆記帳紀錄的 UUID
    @NSManaged var id: UUID
    
    /// 該筆記帳紀錄的建立時間戳
    @NSManaged var createTimestamp: Int64
    
    /// 該筆記帳紀錄的更新時間戳
    @NSManaged var updateTimestamp: Int64
    
    /// 該筆記帳紀錄的紀錄種類，支出／收入
    @NSManaged var recordType: String
    
    /// 該筆記帳紀錄的項目名稱
    @NSManaged var itemName: String
    
    /// 該筆記帳紀錄的項目金額
    @NSManaged var itemPrice: String
    
    /// 該筆記帳紀錄的補充說明
    @NSManaged var notes: String
}
