//
//  CoreStorageManager.swift
//  CoreStorageKit
//
//  Created by Manish on 26/09/21.
//

import Foundation
import CoreData

/// Thread-safe manager for working with local storage.
///
/// - Important:
///     - It's always safe to use single instance for each data model
public class CoreStorageManager: CoreStorageProvider {
    
    private(set) public var persistentContainer: NSPersistentContainer?
    public let coreDataModelBundle: Bundle
    public let coreDataModelName: String
    
    required public init(with coreDataModelName: String,
                         coreDataModelBundle: Bundle,
                         onCompletion: @escaping (Error?) -> Void) {
        self.coreDataModelName = coreDataModelName
        self.coreDataModelBundle = coreDataModelBundle
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
            onCompletion(CoreStorageProviderError.savingFailed(error))
        }
    }
    
    public func fetch<ManagedObject: NSManagedObject>(entity: ManagedObject.Type,
                                                      with predicate: NSPredicate?,
                                                      onCompletion: @escaping ([NSManagedObject]?, Error?) -> Void) {
        
        do {
            let safePersistentContainer = try self.getPersistentContainer()
            
            safePersistentContainer.performBackgroundTask { context in
                do {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
                    fetchRequest.predicate = predicate
                    
                    if let result = try context.fetch(fetchRequest) as? [NSManagedObject] {
                        onCompletion(result, nil)
                        
                        return
                    }
                    
                    onCompletion(nil, CoreStorageProviderError.fetchingFailed(CoreStorageProviderError.fetchResultConvertionFailed))
                } catch {
                    onCompletion(nil, CoreStorageProviderError.fetchingFailed(error))
                }
            }
            
        } catch {
            onCompletion(nil, CoreStorageProviderError.fetchingFailed(error))
        }
        
    }
    
    public func delete(managedObject: NSManagedObject,
                       onCompletion: @escaping (Error?) -> Void) {
        do {
            let safePersistentContainer = try self.getPersistentContainer()
            
            safePersistentContainer.performBackgroundTask { context in
                context.delete(managedObject)
                
                self.save { error in
                    onCompletion(error)
                }
            }
        } catch {
            onCompletion(error)
        }
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
        
        if let dataModelURL = self.coreDataModelBundle.url(forResource: self.coreDataModelName, withExtension: "momd"),
           let managedObjectModel =  NSManagedObjectModel(contentsOf: dataModelURL) {
            let container = NSPersistentContainer(name: self.coreDataModelName, managedObjectModel: managedObjectModel)
            container.loadPersistentStores { des, error in
                onCompletion(error)
            }
            
            self.persistentContainer = container
        } else {
            onCompletion(CoreStorageProviderError.couldNotFindCoreDataModel(withName: self.coreDataModelName,
                                                                            inBundle: self.coreDataModelBundle))
        }
        
    }
    
}
