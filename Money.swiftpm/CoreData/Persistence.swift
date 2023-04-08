//
//  Persistence.swift
//  Money
//
//  Created by Leo Ho on 2023/1/20.
//

import SwiftUI
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // 建立一個 Entity
        let moneyRecordEntity = NSEntityDescription()
        moneyRecordEntity.name = "MoneyRecord"
        moneyRecordEntity.managedObjectClassName = "MoneyRecord"
        
        // 在 Entity 內建立一個型別為 UUID 的 id 屬性
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .uuid
        moneyRecordEntity.properties.append(idAttribute)
        
        // 在 Entity 內建立一個型別為 String 的 createdAt 屬性
        let createdAtAttribute = NSAttributeDescription()
        createdAtAttribute.name = "createdAt"
        createdAtAttribute.type = .string
        moneyRecordEntity.properties.append(createdAtAttribute)
        
        // 在 Entity 內建立一個型別為 Int64 的 createTimestamp 屬性
        let createTimestampAttribute = NSAttributeDescription()
        createTimestampAttribute.name = "createTimestamp"
        createTimestampAttribute.type = .integer64
        moneyRecordEntity.properties.append(createTimestampAttribute)
        
        // 在 Entity 內建立一個型別為 Int64 的 updateTimestamp 屬性
        let updateTimestampAttribute = NSAttributeDescription()
        updateTimestampAttribute.name = "updateTimestamp"
        updateTimestampAttribute.type = .integer64
        moneyRecordEntity.properties.append(updateTimestampAttribute)
        
        // 在 Entity 內建立一個型別為 String 的 recordType 屬性
        let recordTypeAttribute = NSAttributeDescription()
        recordTypeAttribute.name = "recordType"
        recordTypeAttribute.type = .string
        moneyRecordEntity.properties.append(recordTypeAttribute)
        
        // 在 Entity 內建立一個型別為 String 的 itemName 屬性
        let itemNameAttribute = NSAttributeDescription()
        itemNameAttribute.name = "itemName"
        itemNameAttribute.type = .string
        moneyRecordEntity.properties.append(itemNameAttribute)
        
        // 在 Entity 內建立一個型別為 String 的 itemPrice 屬性
        let itemPriceAttribute = NSAttributeDescription()
        itemPriceAttribute.name = "itemPrice"
        itemPriceAttribute.type = .string
        moneyRecordEntity.properties.append(itemPriceAttribute)
        
        // 在 Entity 內建立一個型別為 String 的 notes 屬性
        let notesPriceAttribute = NSAttributeDescription()
        notesPriceAttribute.name = "notes"
        notesPriceAttribute.type = .string
        moneyRecordEntity.properties.append(notesPriceAttribute)
        
        // 建立一個包含 Entity 的 CoreData Model
        let model = NSManagedObjectModel()
        model.entities = [moneyRecordEntity]
        
        container = NSPersistentContainer(name: "MoneyRecordModel", managedObjectModel: model)
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print(storeDescription)
            }
        }
        
//        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// 刪除 CoreData Entity 內全部的資料
    /// - Parameters:
    ///   - data: FetchedResults`<Result>`，Result: NSFetchRequestResult
    func deleteAllData<Result>(data: FetchedResults<Result>) where Result: NSFetchRequestResult {
        data.forEach { record in
            container.viewContext.delete(record as! NSManagedObject)
        }
        
        do {
            try container.viewContext.save()
        } catch {
            print("清除 CoreData 所有資料，Error：\(error.localizedDescription)")
        }
    }
}
