//
//  TestCoreStorageManager.swift
//  CoreStorageKitTests
//
//  Created by Manish on 20/09/21.
//

@testable import CoreStorageKit
import XCTest
import CoreData

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

// MARK: - Test Operations
extension TestCoreStorageManager {
    
    func test_createAndFetch_success() {
        do {
            let safeContext = try self.sut.getManagedObjectContext()
            
            let saveExp = expectation(description: "test_create_success_save")
            let fetchExp = expectation(description: "test_create_success_fetch")
            
            var _savedTestToDo: TestToDo?
            var _saveError: Error?
            var _fetchError: Error?
            var _fetchedToDo: TestToDoEntity?
            
            // save
            self.saveNewTestToDo(context: safeContext) { savedTestToDo, error in
                _savedTestToDo = savedTestToDo
                _saveError = error
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
            XCTAssertEqual(_fetchedToDo!.id, _savedTestToDo?.todoId)
            XCTAssertEqual(_fetchedToDo!.text, _savedTestToDo?.todoText)
            XCTAssertEqual(_fetchedToDo!.createdAt, _savedTestToDo?.todoCreatedAt)
            
        } catch {
            assertionFailure()
        }
        
    }
    
    func test_deleteSaved_success() {
        do {
            let safeContext = try self.sut.getManagedObjectContext()
            
            let saveExp = expectation(description: "test_create_success_save")
            let fetchExp = expectation(description: "test_create_success_fetch")
            let deleteExp = expectation(description: "test_create_success_delete")
            
            var _savedTestToDo: TestToDo?
            var _fetchedToDo: TestToDoEntity?
            var _saveError: Error?
            var _fetchError: Error?
            var _deleteError: Error?
            
            // save
            self.saveNewTestToDo(context: safeContext) { savedTestToDo, error in
                _savedTestToDo = savedTestToDo
                _saveError = error
                saveExp.fulfill()
                
                // fetch
                self.sut.fetch(entity: TestToDoEntity.self, with: nil) { savedToDo, err in
                    _fetchedToDo = savedToDo?.first as? TestToDoEntity
                    _fetchError = err
                    
                    fetchExp.fulfill()
                    
                    // delete
                    self.sut.delete(managedObject: _fetchedToDo!) { error in
                        _deleteError = error
                        deleteExp.fulfill()
                    }
                }
            }
            
            
            wait(for: [saveExp, fetchExp, deleteExp], timeout: 2)
            
            XCTAssertNil(_saveError)
            XCTAssertNil(_fetchError)
            XCTAssertNil(_deleteError)
            XCTAssertNotNil(_savedTestToDo)
            XCTAssertNotNil(_fetchedToDo)
            XCTAssertEqual(_fetchedToDo!.id, nil)
            XCTAssertEqual(_fetchedToDo!.text, nil)
            XCTAssertEqual(_fetchedToDo!.createdAt, nil)
            
        } catch {
            assertionFailure()
        }
        
    }
    
}

// MARK: - Test Helpers
extension TestCoreStorageManager {
    
    func saveNewTestToDo(context: NSManagedObjectContext,
                         onResponse: @escaping (TestToDo?, Error?) -> Void) {
        
        let testToDo = TestToDo(todoId: UUID(),
                                todoText: "This is my todo",
                                todoCreatedAt: Date())
        
        // save
        let todo = TestToDoEntity(context: context)
        todo.id = testToDo.todoId
        todo.text = testToDo.todoText
        todo.createdAt = testToDo.todoCreatedAt
        
        self.sut.save { err in
            onResponse(testToDo, err)
        }
        
    }
    
}
