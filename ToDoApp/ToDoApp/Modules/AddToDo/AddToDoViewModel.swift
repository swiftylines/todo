//
//  AddToDoViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class AddToDoViewModel: BaseViewModel {
    
    private let todoHelper: ToDoListHelper
    
    init(todoHelper: ToDoListHelper) {
        self.todoHelper = todoHelper
    }
    
    func initializeData() {
        
    }
    
    func tryCreatingNewToDo(with todoStr: String,
                            onResponse: @escaping (ToDoItem?, Error?) -> Void) {
        do {
            let addedToDoItem = try self.todoHelper.addNewToDo(with: todoStr)
            onResponse(addedToDoItem, nil)
        } catch {
            onResponse(nil, error)
        }
        
    }
    
}
