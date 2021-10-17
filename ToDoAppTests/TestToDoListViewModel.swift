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
