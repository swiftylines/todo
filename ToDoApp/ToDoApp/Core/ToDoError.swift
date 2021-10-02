//
//  ToDoError.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import Foundation

/// Error thrown when performing operations on `ToDoItem`
enum ToDoError: Error {
    /// Trying to save empty todo item
    case emptyDescription
    /// Trying to access a todo item that does not exist
    case doesNotExist
    /// Trying to cast an object into another object
    case convertionFailed(message: String)
}

extension ToDoError: Equatable {
    
    static func == (lhs: ToDoError, rhs: ToDoError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
    
}
