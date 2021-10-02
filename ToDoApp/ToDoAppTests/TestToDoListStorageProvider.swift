//
//  TestToDoListStorageProvider.swift
//  ToDoAppTests
//
//  Created by Manish on 03/10/21.
//

@testable import ToDoApp
import XCTest

class TestToDoListStorageProvider: XCTestCase {
    
    private(set) var sut: ToDoListStorageProvider!
    
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
extension TestToDoListStorageProvider {
    
    func test_createToDo_success() {
        
        let saveExp = expectation(description: "test_createToDo_success")
        let newToDoItem = ToDoItem(id: UUID(),
                                   createdAt: Date(),
                                   description: "Test ToDo Item.")
        
        var _saveError: Error?
        
        self.sut
            .createTodo(with: newToDoItem) { saveErr in
                _saveError = saveErr
                saveExp.fulfill()
            }
        
        wait(for: [saveExp], timeout: 1)
        
        XCTAssertNil(_saveError)
    }
    
    func test_fetchAllToDo_success() {
        
        let saveExp = expectation(description: "test_fetchAAllToDo_success_create")
        let fetchExp = expectation(description: "test_fetchAAllToDo_success_fetch")
        let newToDoItem = ToDoItem(id: UUID(),
                                   createdAt: Date(),
                                   description: "Test ToDo Item.")
        
        var _saveError: Error?
        var _fetchedError: Error?
        var _fetchedToDos: [ToDoItem]?
        
        // create a new todo
        self.sut
            .createTodo(with: newToDoItem) { saveErr in
                _saveError = saveErr
                
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
        XCTAssertEqual(_fetchedToDos?.count, 1)
        XCTAssertEqual(_fetchedToDos?.first?.id, newToDoItem.id)
        XCTAssertEqual(_fetchedToDos?.first?.createdAt, newToDoItem.createdAt)
        XCTAssertEqual(_fetchedToDos?.first?.description, newToDoItem.description)
    }
    
    func test_DeleteToDo_success() {
        
        let saveExp = expectation(description: "test_DeleteToDo_success_create")
        let deleteExp = expectation(description: "test_DeleteToDo_success_delete")
        let fetchExp = expectation(description: "test_fetchAAllToDo_success_fetch")
        let newToDoItem = ToDoItem(id: UUID(),
                                   createdAt: Date(),
                                   description: "Test ToDo Item.")
        
        var _saveError: Error?
        var _deleteError: Error?
        var _fetchedError: Error?
        var _fetchedToDos: [ToDoItem]?
        
        // create a new todo
        self.sut
            .createTodo(with: newToDoItem) { saveErr in
                _saveError = saveErr
                
                saveExp.fulfill()
                
                // delete newly created todo
                self.sut
                    .deleteTodo(with: newToDoItem.id) { deleteErr in
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
    
}
