//
//  TestToDoListDataProvider.swift
//  ToDoAppTests
//
//  Created by Manish on 02/09/21.
//

@testable import ToDoApp
import XCTest

class TestToDoListDataProvider: XCTestCase {
    
    private var sut: ToDoListDataProvider!
    
    override func setUp() {
        super.setUp()
        
        self.sut = MockToDoListDataProvider(todos: [])
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.sut = nil
    }
    
}

// MARK: - Add ToDo tests
extension TestToDoListDataProvider {
    
    func test_addNewTodo_success() {
        // Add
        let _validDescription = "Read some books."
        var _addedToDoItem: ToDoItem?
        var _addError: Error?
        
        do {
            _addedToDoItem = try self.sut.addNewToDo(with: _validDescription)
        } catch {
            _addError = error
        }
        
        // Test
        XCTAssertNil(_addError)
        XCTAssertNotNil(_addedToDoItem)
        XCTAssertTrue(self.sut.todos.contains(where: { $0.id == _addedToDoItem?.id }))
    }
    
    func test_addNewTodo_failed() {
        // Add
        let _inValidDescription = ""
        var _addedToDoItem: ToDoItem?
        var _addError: Error?
        
        do {
            _addedToDoItem = try self.sut.addNewToDo(with: _inValidDescription)
        } catch {
            _addError = error
        }
        
        // Test
        XCTAssertNil(_addedToDoItem)
        XCTAssertFalse(self.sut.todos.contains(where: { $0.id == _addedToDoItem?.id }))
        XCTAssertTrue((_addError as? ToDoError) == ToDoError.emptyDescription)
    }
    
}
