//
//  CoreDataWrapper.swift
//  ChatApp
//
//  Created by Mher Davtyan on 12/4/19.
//  Copyright © 2019 Mher Davtyan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataWrapper {
    static var shared = CoreDataWrapper()
    required init() {}
    
    // MARK: - Persistent container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Chat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // MARK: - JSONDecoder for managedObjects
    var jsonDecoder: JSONDecoder  {
        guard let context = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve managed object context")
        }
        let decoder = JSONDecoder()
        decoder.userInfo[context] = self.persistentContainer.viewContext
        return decoder
    }
    
    func save() {
        let context = self.persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Delete Data
    // Delete all entities data from core data bd
    func deleteAll(completion: ((Bool)->Void)? = nil)  {
        var i = 0
        let entities = self.persistentContainer.managedObjectModel.entities
        entities.forEach { (entity: NSEntityDescription) in
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: entity.managedObjectClassName)
            let deleteRequest = NSBatchDeleteRequest.init(fetchRequest: fetchRequest)
            do {
                try self.persistentContainer.viewContext.execute(deleteRequest)
                try self.persistentContainer.viewContext.save()
                i = i + 1
            } catch {
                completion?(false)
            }
        }
        completion?(i == entities.count)
    }
        
    func insertObject<T: NSManagedObject>(_ obj: T) {
        let existings = CoreDataWrapper.shared.fetchEntityData(entity: T.self)
        if !existings.contains(obj) {
            self.persistentContainer.viewContext.insert(obj)
        }
    }
        
    func insertObjects<T: NSManagedObject>(_ objects: [T]) {
        guard !objects.isEmpty else { return }
        for obj in objects {
            self.persistentContainer.viewContext.insert(obj)
        }
    }
        
    // Delete all data from given entity
    func deleteData<T: NSManagedObject>(entity: T.Type, completion: ((Bool)->Void)? = nil) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = entity.fetchRequest()
        let  persistent = self.persistentContainer
        let deleteRequest = NSBatchDeleteRequest.init(fetchRequest: fetchRequest)
        do {
            try persistent.viewContext.execute(deleteRequest)
            try persistent.viewContext.save()
            completion?(true)
        } catch {
            completion?(false)
        }
    }
        
    // get data of entity from storage
    func fetchEntityData<T: NSManagedObject>(entity: T.Type,
                                             predicate: NSPredicate? = nil,
                                             sort: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: "\(entity)")
        let  persistent = self.persistentContainer
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sort
        
        do {
            return try persistent.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
