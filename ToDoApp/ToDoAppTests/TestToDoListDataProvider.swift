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

extension TestToDoListDataProvider {
    
    func test_addNewTodo_success() {
        
    }
    
}
