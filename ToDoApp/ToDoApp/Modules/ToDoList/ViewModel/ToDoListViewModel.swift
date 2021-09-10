//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class ToDoListViewModel: BaseViewModel, ToDoListDataProvider {
    
    weak var delegate: ToDoListViewModelDelegate?
    
    var todos = [ToDoItem]() {
        didSet {
            self.delegate?.didUpdateToDos()
        }
    }
    
    func initializeData() {
        
    }
    
}
