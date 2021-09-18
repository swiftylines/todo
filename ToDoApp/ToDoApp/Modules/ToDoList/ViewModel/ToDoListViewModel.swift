//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class ToDoListViewModel: BaseViewModel {
    
    private let todoHelper = ToDoListHelper.shared
    
    var todos: [ToDoItem] {
        return self.todoHelper.todos
    }
    
    func initializeData() {
        
    }
    
}
