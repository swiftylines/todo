//
//  MockToDoListStorageHelper.swift
//  ToDoAppTests
//
//  Created by Manish on 03/10/21.
//

@testable import CoreStorageKit
@testable import ToDoApp

class MockToDoListStorageHelper: ToDoListStorageHelper {
    
    init() {
        let testDataModelName = "ToDoStorage"
        let bundle = Bundle(for: ToDoListStorageHelper.self)
        
        let inMemoryStorageManager = CoreStorageManager(with: testDataModelName,
                                                        coreDataModelBundle: bundle,
                                                        shouldStoreInMemoryOnly: true) { err in
            if err != nil {
                assertionFailure(err.debugDescription)
            }
        }
        
        super.init(storageManager: inMemoryStorageManager)
    }
    
    required init(storageManager: CoreStorageManager) {
        fatalError("init(storageManager:) has not been implemented")
    }
    
}
