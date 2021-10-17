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
            onToDoListUpdate?()
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
    
    func fetchAllToDos() {
        self.todoStorageHelper
            .fetchAllToDoItems { todos, err in
                if err != nil {
                    assertionFailure(err.debugDescription)
                    return
                }
                
                // reset todos
                self.todos = todos
            }
    }
    
    func deleteToDo(at index: Int) {
        if index >= self.todos.count { assertionFailure(); return }
        
        let todoItemUUID = self.todos[index].id
        self.todoStorageHelper
            .deleteTodo(with: todoItemUUID) { err in
                if let _ = err {
                    assertionFailure()
                    return
                }
                
                // remove local ref
                self.todos.remove(at: index)
            }
    }
}
