//
//  ToDoListStorageProvider.swift
//  ToDoApp
//
//  Created by Manish on 02/10/21.
//

import Foundation
import CoreStorageKit

/// Provides local storage features for todo items
protocol ToDoListStorageProvider {
    
    var storageManager: CoreStorageManager { get }
    
    init(storageManager: CoreStorageManager)
    
    /// Creates a new todo in local storage with provided todo item value
    ///
    /// - Parameters:
    ///     - with: todo item that needs to be created/saved locally
    ///     - onResponse: closure executes after todo is saved or if there was any error while saving it.
    func createTodo(with todoItem: ToDoItem,
                    onResponse: @escaping (Error?) -> Void)
    
    /// Fetches all the todo items stored locally
    ///
    /// - Parameters:
    ///     - onResponse: closure executes after todo items are fetched or on error while fetching it.
    ///
    func fetchAllToDoItems(onResponse: @escaping ([ToDoItem], Error?) -> Void)
    
    
    /// Deletes todo item with the provided `id`
    ///
    /// - Important:
    ///     - This function always expects unique todo item on fetch response, which means if there are multiple todos with same id (wrong validation while creating/saving)
    ///         it will only delete the first one.
    ///
    /// - Parameters:
    ///     - id: id of the todo item that needs to be deleted
    ///     - onResponse: Closure executed after deletion or on error while deleting
    ///
    func deleteTodo(with id: UUID,
                    onResponse: @escaping (Error?) -> Void)
    
}

extension ToDoListStorageProvider {
    
    func createTodo(with todoItem: ToDoItem,
                    onResponse: @escaping (Error?) -> Void) {
        do {
            let managedObjectContext = try self.storageManager.getManagedObjectContext()
            
            let managedToDoObject = ToDoItemEntity(context: managedObjectContext)
            managedToDoObject.id = todoItem.id
            managedToDoObject.createdAt = todoItem.createdAt
            managedToDoObject.descText = todoItem.description
            
            self.storageManager.save { err in
                onResponse(err)
            }
            
        } catch {
            onResponse(error)
        }
    }
    
    func fetchAllToDoItems(onResponse: @escaping ([ToDoItem], Error?) -> Void) {
        self.storageManager
            .fetch(entity: ToDoItemEntity.self,
                   with: nil) { fetchedToDoItems, err in
            
            guard err == nil else { onResponse([], err); return }
            
            if let safeToDos = fetchedToDoItems as? [ToDoItemEntity] {
                let mappedToDos = safeToDos.map { ToDoItem(id: $0.id,
                                                           createdAt: $0.createdAt,
                                                           description: $0.descText) }
                onResponse(mappedToDos, nil)
            } else {
                onResponse([], ToDoError.convertionFailed(message: "Could not convert `fetchedToDoItems` in to [ToDoItemEntity]"))
            }
        }
    }
    
    func deleteTodo(with id: UUID,
                    onResponse: @escaping (Error?) -> Void) {
        
        let fetchWithIdPredicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        self.storageManager
            .fetch(entity: ToDoItemEntity.self,
                   with: fetchWithIdPredicate) { fetchedManagedObject, fetchErr in
                guard fetchErr == nil else { onResponse(fetchErr); return }
                
                if let safeFetchedManagedObject = fetchedManagedObject,
                   let firstTodo = safeFetchedManagedObject.first {
                    self.storageManager
                        .delete(managedObject: firstTodo) { delErr in
                            onResponse(delErr)
                        }
                } else {
                    onResponse(ToDoError.doesNotExist)
                }
            }
    }
    
}
