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
        
        self.sut = ToDoListHelper.shared
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

// MARK: - Remove ToDo test
extension TestToDoListDataProvider {
    
    func test_removeToDo_success() {
        
        // Add new item
        let addedItem = try! self.sut.addNewToDo(with: "Write some notes.")
        
        // Remove
        let _validId = addedItem.id
        var _removedToDoItem: ToDoItem?
        var _removeError: Error?
        
        do {
            _removedToDoItem = try self.sut.removeToDo(with: _validId)
        } catch {
            _removeError = error
        }
        
        // Test
        XCTAssertNil(_removeError)
        XCTAssertNotNil(_removedToDoItem)
        XCTAssertTrue(_removedToDoItem?.id == _validId)
    }
    
    func test_removeToDo_failed() {
        // Remove
        let _inValidId = UUID() // random id
        var _removedToDoItem: ToDoItem?
        var _removeError: Error?
        
        do {
            _removedToDoItem = try self.sut.removeToDo(with: _inValidId)
        } catch {
            _removeError = error
        }
        
        // Test
        XCTAssertNil(_removedToDoItem)
        XCTAssertTrue((_removeError as? ToDoError) == .doesNotExist)
    }
    
}
