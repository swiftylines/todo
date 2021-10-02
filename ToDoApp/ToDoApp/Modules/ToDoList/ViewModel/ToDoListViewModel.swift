//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class ToDoListViewModel: BaseViewModel {
    
    // MARK: - Properties
    private(set) var todos = [ToDoItem]()
    let todoStorageHelper: ToDoStorageHelper
    
    // MARK: - Init
    init(todoStorageHelper: ToDoStorageHelper) {
        self.todoStorageHelper = todoStorageHelper
    }
    
    func initializeData() {
        
    }
    
}
