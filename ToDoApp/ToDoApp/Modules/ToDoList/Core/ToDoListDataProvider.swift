//
//  ToDoListDataProvider.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import Foundation

protocol ToDoListDataProvider {
    
    var todos: [ToDoItem] { get set }
    
    mutating func addNewToDo(with description: String) throws -> ToDoItem
    
    mutating func removeToDo(with id: UUID) throws -> ToDoItem
    
}

extension ToDoListDataProvider {
    
    mutating func addNewToDo(with description: String) throws -> ToDoItem {
        // Check for description
        if description.isEmpty {
            throw ToDoError.emptyDescription
        }
        
        // Save
        let todoItem = ToDoItem(id: UUID(),
                                createdAt: Date(),
                                description: description)
        
        // Add to empty list
        if self.todos.isEmpty {
            self.todos.append(todoItem)
            return todoItem
        }
        
        // Add to existing
        // New todos should be added at the top
        self.todos.insert(todoItem, at: 0)
        return todoItem
    }
    
    mutating func removeToDo(with id: UUID) throws -> ToDoItem {
        // Check for index
        if let todoItemIndex = self.todos.firstIndex(where: { $0.id == id }) {
            let todoItem = self.todos[todoItemIndex]
            // Remove
            self.todos.remove(at: todoItemIndex)
            return todoItem
        } else {
            // Error
            throw ToDoError.doesNotExist
        }
    }
    
}
