//
//  TestToDoStorageProvider.swift
//  ToDoAppTests
//
//  Created by Manish on 03/10/21.
//

@testable import ToDoApp
import XCTest

class TestToDoStorageProvider: XCTestCase {
    
    private(set) var sut: ToDoStorageProvider!
    
    override func setUp() {
        super.setUp()
        
        self.sut = MockToDoListStorageHelper()
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.sut = nil
    }
    
}

// MARK: - Test features
extension TestToDoStorageProvider {
    
    func test_createToDo_success() {
        
        let saveExp = expectation(description: "test_createToDo_success")
        
        let createTodoDescription = "Test ToDo Item."
        
        var _saveError: Error?
        var _createdToDo: ToDoItem?
        
        self.sut
            .createTodo(with: createTodoDescription) { createdToDo, saveErr in
                _saveError = saveErr
                _createdToDo = createdToDo
                
                saveExp.fulfill()
            }
        
        wait(for: [saveExp], timeout: 1)
        
        XCTAssertNil(_saveError)
        XCTAssertNotNil(_createdToDo)
        XCTAssertEqual(_createdToDo?.description, createTodoDescription)
    }
    
    func test_createToDo_failed() {
        
        let saveExp = expectation(description: "test_createToDo_failed")
        
        let createTodoDescription = ""
        
        var _saveError: Error?
        var _createdToDo: ToDoItem?
        
        self.sut
            .createTodo(with: createTodoDescription) { createdToDo, saveErr in
                _saveError = saveErr
                _createdToDo = createdToDo
                
                saveExp.fulfill()
            }
        
        wait(for: [saveExp], timeout: 1)
        
        XCTAssertNil(_createdToDo)
        XCTAssertEqual(_saveError?.localizedDescription, ToDoError.emptyDescription.localizedDescription)
    }
    
    func test_fetchAllToDo_success() {
        
        let saveExp = expectation(description: "test_fetchAAllToDo_success_create")
        let fetchExp = expectation(description: "test_fetchAAllToDo_success_fetch")
        
        let newToDoItemDesc = "Test ToDo Item."
        
        var _saveError: Error?
        var _createdToDoItem: ToDoItem?
        
        var _fetchedError: Error?
        var _fetchedToDos: [ToDoItem]?
        
        // create a new todo
        self.sut
            .createTodo(with: newToDoItemDesc) { createdToDoItem, saveErr in
                _saveError = saveErr
                _createdToDoItem = createdToDoItem
                
                saveExp.fulfill()
                
                // fetch newly created todo
                self.sut
                    .fetchAllToDoItems { fetchedToDos, fetchedErr in
                        _fetchedToDos = fetchedToDos
                        _fetchedError = fetchedErr
                        
                        fetchExp.fulfill()
                    }
            }
        
        wait(for: [saveExp, fetchExp], timeout: 1)
        
        XCTAssertNil(_saveError)
        XCTAssertNil(_fetchedError)
        XCTAssertNotNil(_fetchedToDos)
        XCTAssertNotNil(_createdToDoItem)
        XCTAssertEqual(_createdToDoItem?.description, newToDoItemDesc)
        XCTAssertEqual(_fetchedToDos?.count, 1)
        XCTAssertEqual(_fetchedToDos?.first?.description, newToDoItemDesc)
    }
    
    func test_fetchAllToDo_failed() {
        
        let fetchExp = expectation(description: "test_fetchAllToDo_failed_fetch")

        var _fetchedError: Error?
        var _fetchedToDos: [ToDoItem]?
        
        // Currently there is no todo in the sut
        // fetch todo
        self.sut
            .fetchAllToDoItems { fetchedToDos, fetchedErr in
                _fetchedToDos = fetchedToDos
                _fetchedError = fetchedErr
                
                fetchExp.fulfill()
            }
        
        wait(for: [fetchExp], timeout: 1)
        
        XCTAssertNil(_fetchedError)
        XCTAssertEqual(_fetchedToDos?.count, 0)
    }
    
    func test_DeleteToDo_success() {
        
        let saveExp = expectation(description: "test_DeleteToDo_success_create")
        let deleteExp = expectation(description: "test_DeleteToDo_success_delete")
        let fetchExp = expectation(description: "test_fetchAAllToDo_success_fetch")
        
        let newToDoItemDescription = "Test ToDo Item."
        
        var _saveError: Error?
        var _deleteError: Error?
        var _fetchedError: Error?
        var _fetchedToDos: [ToDoItem]?
        
        // create a new todo
        self.sut
            .createTodo(with: newToDoItemDescription) { createdToDo, saveErr in
                _saveError = saveErr
                
                saveExp.fulfill()
                
                // delete newly created todo
                self.sut
                    .deleteTodo(with: createdToDo!.id) { deleteErr in
                        _deleteError = deleteErr
                        deleteExp.fulfill()
                        
                        // try fetching newly created todo
                        self.sut
                            .fetchAllToDoItems { fetchedToDos, fetchedErr in
                                _fetchedToDos = fetchedToDos
                                _fetchedError = fetchedErr
                                
                                fetchExp.fulfill()
                            }
                    }
            }
        
        wait(for: [saveExp, deleteExp, fetchExp], timeout: 1)
        
        XCTAssertNil(_saveError)
        XCTAssertNil(_deleteError)
        XCTAssertNil(_fetchedError)
        XCTAssertEqual(_fetchedToDos?.isEmpty, true)
    }
    
    func test_DeleteToDo_failed() {
        
        let deleteExp = expectation(description: "test_DeleteToDo_failed_delete")
        
        var _deleteError: Error?
        
        // try deleting todo from empty list
        self.sut
            .deleteTodo(with: UUID()) { deleteErr in
                _deleteError = deleteErr
                deleteExp.fulfill()
            }
        
        wait(for: [deleteExp], timeout: 1)
        
        XCTAssertEqual(_deleteError?.localizedDescription, ToDoError.doesNotExist.localizedDescription)
    }
    
}
