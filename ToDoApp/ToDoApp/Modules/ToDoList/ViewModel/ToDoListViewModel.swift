//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class ToDoListViewModel: BaseViewModel {
    
    // MARK: - Properties
    var todos: [ToDoItem] {
        return self.todoHelper.todos
    }
    
    let todoHelper: ToDoListHelper
    
    // MARK: - Init
    init(todoHelper: ToDoListHelper) {
        self.todoHelper = todoHelper
    }
    
    func initializeData() {
        
    }
    
}
