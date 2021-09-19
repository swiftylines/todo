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
    private var toDoListHelper: ToDoListHelper!
    
    override func setUp() {
        super.setUp()
        
        self.sut = ToDoListViewModel()
        self.toDoListHelper = ToDoListHelper.shared
    }
    
    override func tearDown() {
        super.tearDown()
        
        
        self.sut = nil
        
        // remove all todos
        let todoIds = self.toDoListHelper.todos.map { $0.id }
        todoIds.forEach {
            _ = try? self.toDoListHelper.removeToDo(with: $0)
        }
    }
    
}

extension TestToDoListViewModel {
    
    func test_fetchToDos_Empty_success() {
        
        // Initial stage
        // Did not add any todo item
        XCTAssertEqual(0, self.sut.todos.count)
        
    }
    
    func test_fetchToDos_AddedNewItem_success() {
        
        // Data
        var _newToDoItem: ToDoItem?
        var _error: Error?
        
        // Operate
        do {
            _newToDoItem = try ToDoListHelper.shared.addNewToDo(with: "New todo item")
        } catch {
            _error = error
        }
        
        // Test
        XCTAssertNil(_error)
        XCTAssertNotNil(_newToDoItem)
        
        XCTAssertEqual(_newToDoItem?.description, self.sut.todos.first?.description)
    }
    
    func test_fetchToDos_AddedNewItem_failed() {
        
        // Data
        var _newToDoItem: ToDoItem?
        var _error: Error?
        
        // Operate
        do {
            _newToDoItem = try ToDoListHelper.shared.addNewToDo(with: "")
        } catch {
            _error = error
        }
        
        // Test
        XCTAssertNotNil(_error)
        XCTAssertNil(_newToDoItem)
        
        XCTAssertTrue(self.sut.todos.isEmpty)
    }
    
}
