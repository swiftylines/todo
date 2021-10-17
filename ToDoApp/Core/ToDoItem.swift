//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import Foundation

struct ToDoItem {
    
    /// Unique todo identifier
    let id: UUID
    
    /// Date and time, when todo item was created
    let createdAt: Date
    
    /// Todo description
    let description: String
}
