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
    /// - Parameters:
    ///     - id: id of the todo item that needs to be deleted
    ///     - onResponse: Closure executed after deletion or on error while deleting
    func deleteTodo(with id: UUID,
                    onResponse: @escaping (Error?) -> Void)
    
}
