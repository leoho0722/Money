//
//  Persistence.swift
//  Money
//
//  Created by Leo Ho on 2023/6/7.
//

import CoreData
import SwiftUI

struct PersistenceController {
    
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Money")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
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
