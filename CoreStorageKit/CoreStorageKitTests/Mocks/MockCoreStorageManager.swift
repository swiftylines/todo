//
//  MockCoreStorageManager.swift
//  CoreStorageKitTests
//
//  Created by Manish on 27/09/21.
//

@testable import CoreStorageKit
import CoreData

class MockCoreStorageManager: CoreStorageManager {
    
    init(with coreDataModelName: String,
                  coreDataModelBundle: Bundle,
                  onCompletion: @escaping (Error?) -> Void) {
        
        super.init(with: coreDataModelName,
                   coreDataModelBundle: coreDataModelBundle,
                   shouldStoreInMemoryOnly: true,
                   onCompletion: onCompletion)
    }
    
    required init(with coreDataModelName: String,
                  coreDataModelBundle: Bundle,
                  shouldStoreInMemoryOnly: Bool = false,
                  onCompletion: @escaping (Error?) -> Void) {
        fatalError("init(with:coreDataModelBundle:shouldStoreInMemoryOnly:onCompletion:) has not been implemented")
    }
    
}
