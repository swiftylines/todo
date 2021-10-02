//
//  AddToDoViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class AddToDoViewModel: BaseViewModel {
    
    // MARK: - Properties
    let todoStorageHelper: ToDoStorageHelper
    
    // MARK: - Init
    init(todoStorageHelper: ToDoStorageHelper) {
        self.todoStorageHelper = todoStorageHelper
    }
    
    func initializeData() {
        
    }
    
    func tryCreatingNewToDo(with todoStr: String,
                            onResponse: @escaping (ToDoItem?, Error?) -> Void) {
        self.todoStorageHelper.createTodo(with: todoStr) { createdTodo, err in
            if let safeErr = err {
                onResponse(nil, safeErr)
            } else {
                onResponse(createdTodo, nil)
            }
        }
        
    }
    
}
