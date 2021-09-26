//
//  CoreStorageManager.swift
//  CoreStorageKit
//
//  Created by Manish on 26/09/21.
//

import Foundation
import CoreData

public class CoreStorageManager: CoreStorageProvider {
    
    private(set) public var persistentContainer: NSPersistentContainer?
    public let coreDataModelName: String
    
    required public init(with coreDataModelName: String,
                         onCompletion: @escaping (Error?) -> Void) {
        self.coreDataModelName = coreDataModelName
        self.setupPersistentContainer() { err in
            onCompletion(err)
        }
    }
    
    public func save(onCompletion: @escaping (Error?) -> Void) {
        do {
            let safePersistentContainer = try self.getPersistentContainer()
            
            safePersistentContainer.performBackgroundTask { context in
                do {
                    
                    if context.hasChanges {
                        try context.save()
                    }
                    
                    onCompletion(nil)
                } catch {
                    onCompletion(CoreStorageProviderError.savingFailed(error))
                }
            }
        } catch {
            onCompletion(CoreStorageProviderError.savingFailed(CoreStorageProviderError.persistentContainerNil))
        }
    }
    
    public func fetch<ManagedObject: NSManagedObject>(entity: ManagedObject.Type,
                                                      onCompletion: @escaping ([NSManagedObject]?, Error?) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
        
        self.persistentContainer?.performBackgroundTask { context in
            do {
                if let result = try context.fetch(fetchRequest) as? [NSManagedObject] {
                    onCompletion(result, nil)
                    return
                }
                
                onCompletion(nil, CoreStorageProviderError.fetchingFailed(CoreStorageProviderError.fetchResultConvertionFailed))
            } catch {
                onCompletion(nil, CoreStorageProviderError.fetchingFailed(error))
            }
        }
    }
    
    public func delete() {
        
    }
    
}

// MARK: - Helpers
extension CoreStorageManager {
    
    private func getPersistentContainer() throws -> NSPersistentContainer {
        if let safePersistentContainer = self.persistentContainer {
            return safePersistentContainer
        }
        
        throw CoreStorageProviderError.persistentContainerNil
    }
    
    private func setupPersistentContainer(onCompletion: @escaping (Error?) -> Void) {
        let container = NSPersistentContainer(name: self.coreDataModelName)
        container.loadPersistentStores { des, error in
            onCompletion(error)
        }
        
        self.persistentContainer = container
    }
    
}
