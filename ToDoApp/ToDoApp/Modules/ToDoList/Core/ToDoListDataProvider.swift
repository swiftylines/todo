//
//  ToDoListDataProvider.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import Foundation

protocol ToDoListDataProvider {
    
    var todos: [ToDoItem] { get set }
    
    mutating func add(_ todoItem: ToDoItem)
    
    mutating func removeToDo(with id: UUID)
    
}

extension ToDoListDataProvider {
    
    mutating func add(_ todoItem: ToDoItem) {
        if self.todos.isEmpty {
            self.todos.append(todoItem)
            return
        }
        
        self.todos.insert(todoItem, at: 0)
    }
    
    mutating func removeToDo(with id: UUID) {
        self.todos.removeAll { $0.id == id }
    }
    
}
