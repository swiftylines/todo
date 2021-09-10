//
//  ToDoListView+ToDoListViewModelDelegate.swift
//  ToDoApp
//
//  Created by Manish on 04/09/21.
//

import Foundation

extension ToDoListView: ToDoListViewModelDelegate {
    
    func didUpdateToDos() {
        self.safeReloadTodoTableView()
    }
    
    func shouldShowError(with text: String) {
        
    }
    
}

// MARK: - Reload TableView
extension ToDoListView {
    
    func safeReloadTodoTableView() {
        
    }
    
}
