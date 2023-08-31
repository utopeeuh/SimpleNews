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
  
  func fetchEntities<T: NSManagedObject>(_ entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
      return []
    }
    
    let fetchRequest = NSFetchRequest<T>()
    fetchRequest.entity = entityDescription
    fetchRequest.predicate = predicate
    fetchRequest.sortDescriptors = sortDescriptors
    
    do {
      return try context.fetch(fetchRequest)
    } catch {
      print("Error fetching data: \(error)")
      return []
    }
  }
  
  func createEntity<T: NSManagedObject>(_ entityName: String) -> T {
    guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
      fatalError("Entity not found: \(entityName)")
    }
    let entity = T(entity: entityDescription, insertInto: context)
    return entity
  }
  
  func deleteEntity(_ entityName: String, predicate: NSPredicate) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = predicate
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
      try context.execute(deleteRequest)
      saveContext()
    } catch {
      print("Error deleting entity: \(error)")
    }
  }
  
  func deleteFirstEntity(_ entityName: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.fetchLimit = 1
    
    do {
      if let firstEntity = try context.fetch(fetchRequest).first as? NSManagedObject {
        context.delete(firstEntity)
        saveContext()
      }
    } catch {
      print("Error deleting entity: \(error)")
    }
  }
}


