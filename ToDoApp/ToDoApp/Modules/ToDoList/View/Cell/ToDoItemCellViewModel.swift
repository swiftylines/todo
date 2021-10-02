//
//  ToDoItemCellViewModel.swift
//  ToDoApp
//
//  Created by Manish on 04/09/21.
//

import CoreUIKit

struct ToDoItemCellViewModel: BaseViewModel {
    
    let todoItem: ToDoItem
    
    var createdAtStr: String {
        return ToDoDateFormat.localFormate(from: self.todoItem.createdAt)
    }
    
}
