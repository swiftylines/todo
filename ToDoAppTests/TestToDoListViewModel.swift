//
//  TestToDoListViewModel.swift
//  ToDoAppTests
//
//  Created by Manish on 19/09/21.
//

@testable import ToDoApp
import XCTest

class TestToDoListViewModel: XCTestCase {
    
    private var sut: ToDoListViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.sut = ToDoListViewModel(todoStorageHelper: MockToDoListStorageHelper())
    }
    
    override func tearDown() {
        super.tearDown()
        
        
        self.sut = nil
    }
    
}

extension TestToDoListViewModel {
    
    func test_FetchAllToDos() {
        let _newToDoDesc = "New todo Item"
        var _createdToDoItem: ToDoItem?
        var _createdError: Error?
        
        let _createToDoExp = expectation(description: "createTodo_exp")
        let _initializeDataExp = expectation(description: "initializeData_exp")
        
        // Create new item
        self.sut.todoStorageHelper.createTodo(with: _newToDoDesc) { toDoItem, err in
            _createdToDoItem = toDoItem
            _createdError = err
            
            _createToDoExp.fulfill()
        }
        
        wait(for: [_createToDoExp], timeout: 5)
        
        // initialize
        self.sut.fetchAllToDos() {
            _initializeDataExp.fulfill()
        }
        
        wait(for: [_initializeDataExp], timeout: 5)
        
        XCTAssertNil(_createdError)
        XCTAssertEqual(self.sut.todos.count, 1)
        XCTAssertEqual(self.sut.todos.first?.id, _createdToDoItem?.id)
        XCTAssertEqual(self.sut.todos.first?.description, _createdToDoItem?.description)
        XCTAssertEqual(self.sut.todos.first?.description, _newToDoDesc)
    }
    
    func test_didAddNew() {
        let _newToDoItem = ToDoItem(id: UUID(), createdAt: Date(),
                                   description: "New ToDo Item")
        
        self.sut.didAddNew(toDoItem: _newToDoItem)
        
        XCTAssertEqual(self.sut.todos.count, 1)
        XCTAssertEqual(self.sut.todos.first?.id, _newToDoItem.id)
        XCTAssertEqual(self.sut.todos.first?.description, _newToDoItem.description)
        XCTAssertEqual(self.sut.todos.first?.createdAt, _newToDoItem.createdAt)
    }
    
    func test_deleteToDo() {
        let _newToDoDesc = "New todo Item"
        var _createdToDoItem: ToDoItem?
        var _createdError: Error?
        var _deleteStatus: Bool?
        
        let _createToDoExp = expectation(description: "createTodo_exp")
        let _deleteToDoExp = expectation(description: "initializeData_exp")
        
        // Create new item
        self.sut.todoStorageHelper.createTodo(with: _newToDoDesc) { toDoItem, err in
            _createdToDoItem = toDoItem
            _createdError = err
            
            self.sut.didAddNew(toDoItem: toDoItem!)
            
            _createToDoExp.fulfill()
        }
        
        wait(for: [_createToDoExp], timeout: 5)
        
        // delete
        self.sut.deleteToDo(at: 0) { deleteStatus in
            _deleteStatus = deleteStatus
            
            _deleteToDoExp.fulfill()
        }
        
        wait(for: [_deleteToDoExp], timeout: 5)
        
        XCTAssertNil(_createdError)
        XCTAssertEqual(self.sut.todos.count, 0)
        XCTAssertNotNil(_createdToDoItem)
        XCTAssertTrue(_deleteStatus ?? false)
    }
    
    func test_deleteToDo_failed() {
        var _deleteStatus: Bool?
        
        let exp = expectation(description: "deleteToDo_exp")
        
        // Empty todo list
        // Delete should fail
        self.sut.deleteToDo(at: 0) { deleteStatus in
            _deleteStatus = deleteStatus
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5)
        
        XCTAssertFalse(_deleteStatus ?? true)
    }
    
}
