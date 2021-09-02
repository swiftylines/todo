//
//  ToDoListDataProvider.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import Foundation

protocol ToDoListDataProvider {
    
    var todos: [ToDoItem] { get set }
    
    mutating func addNewToDo(with description: String) throws
    
    mutating func removeToDo(with id: UUID) throws
    
}

extension ToDoListDataProvider {
    
    mutating func addNewToDo(with description: String) throws {
        // Check for description
        if description.isEmpty {
            throw ToDoError.emptyDescription
        }
        
        // Save
        let todoItem = ToDoItem(id: UUID(),
                                createdAt: Date(),
                                description: description)
        
        if self.todos.isEmpty {
            self.todos.append(todoItem)
            return
        }
        
        // New todos should be added at the top
        self.todos.insert(todoItem, at: 0)
    }
    
    mutating func removeToDo(with id: UUID) throws {
        // Check for index
        if let todoItemIndex = self.todos.firstIndex(where: { $0.id == id }) {
            // Remove
            self.todos.remove(at: todoItemIndex)
        } else {
            // Error
            throw ToDoError.doesNotExist
        }
    }
    
}
