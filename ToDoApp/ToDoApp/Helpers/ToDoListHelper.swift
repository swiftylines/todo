//
//  ToDoListHelper.swift
//  ToDoApp
//
//  Created by Manish on 18/09/21.
//

import Foundation

class ToDoListHelper: ToDoListDataProvider {
    
    private(set) var todos = [ToDoItem]()
    private let storageHelper: ToDoListStorageHelper
    
    init(storageHelper: ToDoListStorageHelper) {
        self.storageHelper = storageHelper
    }
    
}

extension ToDoListHelper {
    
    @discardableResult
    func addNewToDo(with description: String) throws -> ToDoItem {
        
        let safeDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check for description
        if safeDescription.isEmpty {
            throw ToDoError.emptyDescription
        }
        
        // Save
        let todoItem = ToDoItem(id: UUID(),
                                createdAt: Date(),
                                description: safeDescription)
        
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
    
    @discardableResult
    func removeToDo(with id: UUID) throws -> ToDoItem {
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
