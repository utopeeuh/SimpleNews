//
//  CoreDataHelper.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation
import CoreData

class CoreDataHelper {
  
  static let shared = CoreDataHelper()
  
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "SimpleNews")
    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func fetchEntities<T: NSManagedObject>(_ entityClass: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
    let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
    fetchRequest.predicate = predicate
    fetchRequest.sortDescriptors = sortDescriptors
    
    do {
      return try context.fetch(fetchRequest)
    } catch {
      print("Error fetching data: \(error)")
      return []
    }
  }
  
  func createEntity<T: NSManagedObject>(_ entityClass: T.Type) -> T {
    return T(context: context)
  }
  
  func deleteEntity(_ entity: NSManagedObject) {
    context.delete(entity)
    saveContext()
  }
  
  func deleteFirstEntity<T: NSManagedObject>(_ entityClass: T.Type) {
    let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
    fetchRequest.fetchLimit = 1
    
    do {
      if let firstEntity = try context.fetch(fetchRequest).first {
        context.delete(firstEntity)
        saveContext()
      }
    } catch {
      print("Error deleting entity: \(error)")
    }
  }
}


