//
//  CoreDataService.swift
//  ValuateMyCar
//
//  Created by Júlio César Correia Teixeira on 02/09/22.
//

import Foundation
import CoreData

class CoreDataService {
    static let shared = CoreDataService()
    
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "ValuateMyCar")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(String(describing: error))")
            }
        }
        
        mainContext = persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
