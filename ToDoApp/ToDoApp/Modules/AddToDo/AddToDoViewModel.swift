//
//  AddToDoViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class AddToDoViewModel: BaseViewModel {
    
    private var todoHelper = ToDoListHelper.shared
    
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
