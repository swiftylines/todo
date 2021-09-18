//
//  ToDoListDataProvider.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import Foundation

protocol ToDoListDataProvider: AnyObject {
    
    var todos: [ToDoItem] { get }
    
    func addNewToDo(with description: String) throws -> ToDoItem
    
    func removeToDo(with id: UUID) throws -> ToDoItem
    
}
