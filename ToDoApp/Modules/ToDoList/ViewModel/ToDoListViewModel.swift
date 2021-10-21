//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import CoreUIKit

class ToDoListViewModel: BaseViewModel {
    
    // MARK: - Properties
    private(set) var todos = [ToDoItem]() {
        didSet {
            self.onToDoListUpdate?()
        }
    }
    
    let todoStorageHelper: ToDoStorageHelper
    var onToDoListUpdate: (() -> Void)?
    
    // MARK: - Init
    init(todoStorageHelper: ToDoStorageHelper) {
        self.todoStorageHelper = todoStorageHelper
    }
    
    func initializeData() {
        self.fetchAllToDos()
    }
    
    /// Should be invoked with newly added todo item after new todo item is saved
    /// - Parameter toDoItem: newly created todo item
    func didAddNew(toDoItem: ToDoItem) {
        if self.todos.isEmpty {
            self.todos.append(toDoItem)
        } else {
            self.todos.insert(toDoItem, at: 0)
        }
    }
    
    func fetchAllToDos(onResponse: (() -> Void)? = nil) {
        self.todoStorageHelper
            .fetchAllToDoItems { todos, err in
                if err != nil {
                    onResponse?()
                    assertionFailure(err.debugDescription)
                    return
                }
                
                // reset todos
                self.todos = todos
                onResponse?()
            }
    }
    
    func deleteToDo(at index: Int,
                    onResponse: ((Bool) -> Void)? = nil) {
        if index >= self.todos.count {
            onResponse?(false)
            return
        }
        
        let todoItemUUID = self.todos[index].id
        self.todoStorageHelper
            .deleteTodo(with: todoItemUUID) { err in
                if let _ = err {
                    onResponse?(false)
                    assertionFailure()
                    return
                }
                
                // remove local ref
                self.todos.remove(at: index)
                onResponse?(true)
            }
    }
}
