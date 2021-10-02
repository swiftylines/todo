//
//  ToDoStorageHelper.swift
//  ToDoApp
//
//  Created by Manish on 02/10/21.
//

import Foundation
import CoreStorageKit

/// Provides todo storage features, such as creating and deleting a todo item
///
/// - Important
///     - It's not recommended to use  `ToDoListStorageHelper` directly, because it will directly perform the operation with the provided data.
///
class ToDoStorageHelper: ToDoStorageProvider {
    
    let storageManager: CoreStorageManager
    
    required init(storageManager: CoreStorageManager) {
        self.storageManager = storageManager
    }
    
}
