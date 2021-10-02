//
//  TestCoreStorageManager.swift
//  CoreStorageKitTests
//
//  Created by Manish on 20/09/21.
//

@testable import CoreStorageKit
import XCTest

class TestCoreStorageManager: XCTestCase {
    
    private var sut: CoreStorageProvider!
    
    override func setUp() {
        super.setUp()
        
        self.sut = MockCoreStorageManager(with: "TestCoreDataModel",
                                          coreDataModelBundle: Bundle(for: type(of: self))) { err in
            assert(err == nil)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.sut = nil
    }
    
}

// MARK: - Setup data model
extension TestCoreStorageManager {
    
    func test_init_success() {
        
        let expInit = expectation(description: "test_init_success_init")
        let expSave = expectation(description: "test_init_success_save")
        
        var _initError: Error?
        var _saveError: Error?
        
        let manager = MockCoreStorageManager(with: "TestCoreDataModel",
                                             coreDataModelBundle: Bundle(for: type(of: self))) { err in
            _initError = err
            expInit.fulfill()
        }
        
        manager.save { err in
            _saveError = err
            expSave.fulfill()
        }
        
        wait(for: [expInit, expSave], timeout: 2)
        
        XCTAssertNil(_initError)
        XCTAssertNil(_saveError)
    }
    
    func test_init_failed() {
        
        let expInit = expectation(description: "test_init_success_init")
        let expSave = expectation(description: "test_init_success_save")
        
        let dataModelName = "WrongDataModelName"
        let bundle = Bundle(for: type(of: self))
        
        var _initError: Error?
        var _saveError: Error?
        
        let manager = MockCoreStorageManager(with: dataModelName,
                                             coreDataModelBundle: bundle) { err in
            _initError = err
            expInit.fulfill()
        }
        
        manager.save { err in
            _saveError = err
            expSave.fulfill()
        }
        
        wait(for: [expInit, expSave], timeout: 2)
        
        XCTAssertNotNil(_initError)
        XCTAssertNotNil(_saveError)
        XCTAssertEqual(_initError?.localizedDescription,
                       CoreStorageProviderError.couldNotFindCoreDataModel(withName: dataModelName,
                                                                          inBundle: bundle).localizedDescription)
    }
    
}

extension TestCoreStorageManager {
    
    func test_create_success() {
        do {
            let safeContext = try self.sut.getManagedObjectContext()
            
            let saveExp = expectation(description: "test_create_success_save")
            let fetchExp = expectation(description: "test_create_success_fetch")
            
            let todoId = UUID()
            let todoText = "This is my todo"
            let todoCreatedAt = Date()
            
            var _saveError: Error?
            var _fetchError: Error?
            var _fetchedToDo: TestToDoEntity?
            
            // save
            let todo = TestToDoEntity(context: safeContext)
            todo.id = todoId
            todo.text = todoText
            todo.createdAt = todoCreatedAt
            
            self.sut.save { err in
                _saveError = err
                saveExp.fulfill()
                
                // fetch
                self.sut.fetch(entity: TestToDoEntity.self, with: nil) { savedToDo, err in
                    _fetchedToDo = savedToDo?.first as? TestToDoEntity
                    _fetchError = err
                    
                    fetchExp.fulfill()
                }
            }
            
            wait(for: [saveExp, fetchExp], timeout: 2)
            
            XCTAssertNil(_saveError)
            XCTAssertNil(_fetchError)
            XCTAssertNotNil(_fetchedToDo)
            XCTAssertEqual(_fetchedToDo!.id, todoId)
            XCTAssertEqual(_fetchedToDo!.text, todoText)
            XCTAssertEqual(_fetchedToDo!.createdAt, todoCreatedAt)
            
        } catch {
            assertionFailure()
        }
        
    }
    
}
