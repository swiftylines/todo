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
    public let shouldStoreInMemoryOnly: Bool
    
    required public init(with coreDataModelName: String,
                         coreDataModelBundle: Bundle,
                         shouldStoreInMemoryOnly: Bool = false,
                         onCompletion: @escaping (Error?) -> Void) {
        self.coreDataModelName = coreDataModelName
        self.coreDataModelBundle = coreDataModelBundle
        self.shouldStoreInMemoryOnly = shouldStoreInMemoryOnly
        
        self.setupPersistentContainer() { err in
            onCompletion(err)
        }
    }
    
    public func save(onCompletion: @escaping (Error?) -> Void) {
        do {
            let safePersistentContainer = try self.getPersistentContainer()
            let safeManagedContext = try self.getManagedObjectContext()
            
            safePersistentContainer.performBackgroundTask { _ in
                do {
                    if safeManagedContext.hasChanges {
                        try safeManagedContext.save()
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
                                                      with predicate: NSPredicate? = nil,
                                                      onCompletion: @escaping ([NSManagedObject]?, Error?) -> Void) {
        
        do {
            let safePersistentContainer = try self.getPersistentContainer()
            let safeManagedContext = try self.getManagedObjectContext()
            
            safePersistentContainer.performBackgroundTask { _ in
                do {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
                    fetchRequest.predicate = predicate
                    
                    if let result = try safeManagedContext.fetch(fetchRequest) as? [NSManagedObject] {
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
            let safeManagedContext = try self.getManagedObjectContext()
            
            safePersistentContainer.performBackgroundTask { _ in
                safeManagedContext.delete(managedObject)
                
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
    
    func getPersistentContainer() throws -> NSPersistentContainer {
        if let safePersistentContainer = self.persistentContainer {
            return safePersistentContainer
        }
        
        throw CoreStorageProviderError.persistentContainerNil
    }
    
    public func getManagedObjectContext() throws -> NSManagedObjectContext {
        do {
            return try self.getPersistentContainer().viewContext
        } catch {
            throw error
        }
    }
    
    private func setupPersistentContainer(onCompletion: @escaping (Error?) -> Void) {
        
        if let dataModelURL = self.coreDataModelBundle.url(forResource: self.coreDataModelName, withExtension: "momd"),
           let managedObjectModel =  NSManagedObjectModel(contentsOf: dataModelURL) {
            
            let container = NSPersistentContainer(name: self.coreDataModelName, managedObjectModel: managedObjectModel)
            
            // Configure in-memory storage
            if self.shouldStoreInMemoryOnly {
                let storeDescription = NSPersistentStoreDescription()
                storeDescription.url = URL(fileURLWithPath: "/dev/null")
                storeDescription.type = NSInMemoryStoreType
                container.persistentStoreDescriptions = [storeDescription]
            }
            
            // Load store
            container.loadPersistentStores { des, error in
                onCompletion(error)
            }
            
            // local ref
            self.persistentContainer = container
        } else {
            onCompletion(CoreStorageProviderError.couldNotFindCoreDataModel(withName: self.coreDataModelName,
                                                                            inBundle: self.coreDataModelBundle))
        }
        
    }
    
}
