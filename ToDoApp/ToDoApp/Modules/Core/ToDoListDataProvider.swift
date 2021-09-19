//
//  ToDoListDataProvider.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import Foundation

protocol ToDoListDataProvider: AnyObject {
    
    /// Saved ToDo items
    var todos: [ToDoItem] { get }
    
    /// Adds new todo item with provided description string.
    ///
    /// - Throws:
    ///     - When `description` is empty/just new line
    ///
    ///
    /// - Parameter description: todo description
    ///
    /// - Returns: `ToDoItem`, when todo is added successfully
    func addNewToDo(with description: String) throws -> ToDoItem
    
    /// Removes existing todo item with provided `id`
    ///
    /// - Throws:
    ///     - When todo item does not exisit with provided `id`
    ///
    /// - Parameter id: todo id
    ///
    /// - Returns: removed todo item
    func removeToDo(with id: UUID) throws -> ToDoItem
    
}
