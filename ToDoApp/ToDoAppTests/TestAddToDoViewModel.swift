//
//  TestAddToDoViewModel.swift
//  ToDoAppTests
//
//  Created by Manish on 19/09/21.
//

@testable import ToDoApp
import XCTest

class TestAddToDoViewModel: XCTestCase {
    
    private var sut: AddToDoViewModel!
    
    override func setUp() {
        super.setUp()
        
        let toDoListHelper = ToDoListHelper(storageHelper: MockToDoListStorageHelper())
        self.sut = AddToDoViewModel(todoHelper: toDoListHelper)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.sut = nil
    }
    
}

extension TestAddToDoViewModel {
    
    func test_tryCreatingNewToDo_success() {
        // Data
        let _todoStr = "My new todo text"
        
        let exp = expectation(description: "test_tryCreatingNewToDo_success")
        
        var _addedToDoItem: ToDoItem?
        var _error: Error?
        
        // Operation
        self.sut
            .tryCreatingNewToDo(with: _todoStr) { addedToDoItem, error in
                _addedToDoItem = addedToDoItem
                _error = error
                
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 10)
        
        // Tests
        XCTAssertNil(_error)
        XCTAssertNotNil(_addedToDoItem)
        XCTAssertEqual(_todoStr, _addedToDoItem?.description)
    }
    
    func test_tryCreatingNewToDo_Failed() {
        // Data
        let _todoStr = ""
        
        let exp = expectation(description: "test_tryCreatingNewToDo_success")
        
        var _addedToDoItem: ToDoItem?
        var _error: Error?
        
        // Operation
        self.sut
            .tryCreatingNewToDo(with: _todoStr) { addedToDoItem, error in
                _addedToDoItem = addedToDoItem
                _error = error
                
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 10)
        
        // Tests
        XCTAssertNotNil(_error)
        XCTAssertNil(_addedToDoItem)
    }
    
    func test_tryCreatingNewToDo_emptyNewLine_Failed() {
        // Data
        let _todoStr = """

                        """
        
        let exp = expectation(description: "test_tryCreatingNewToDo_success")
        
        var _addedToDoItem: ToDoItem?
        var _error: Error?
        
        // Operation
        self.sut
            .tryCreatingNewToDo(with: _todoStr) { addedToDoItem, error in
                _addedToDoItem = addedToDoItem
                _error = error
                
                exp.fulfill()
            }
        
        wait(for: [exp], timeout: 10)
        
        // Tests
        XCTAssertNotNil(_error)
        XCTAssertNil(_addedToDoItem)
    }
    
}
