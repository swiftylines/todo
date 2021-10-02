//
//  CoreStorageProvider.swift
//  CoreStorageKit
//
//  Created by Manish on 20/09/21.
//

import CoreData

protocol CoreStorageProvider {
    
    // MARK: - Properties
    var persistentContainer: NSPersistentContainer? { get }
    var coreDataModelName: String { get }
    var coreDataModelBundle: Bundle { get }
    var shouldStoreInMemoryOnly: Bool { get }
    
    // MARK: - Init
    init(with coreDataModelName: String,
         coreDataModelBundle: Bundle,
         shouldStoreInMemoryOnly: Bool,
         onCompletion: @escaping (Error?) -> Void)
    
    // MARK: - Getters
    func getPersistentContainer() throws -> NSPersistentContainer
    func getManagedObjectContext() throws -> NSManagedObjectContext
    
    // MARK: - Features
    
    /// Saves context of current managed object
    ///
    /// - Important:
    ///     - Retruns result on the caller thread
    ///
    /// - Parameter:
    ///     - onCompletion: Closure, executed after success/failed save operation with any possible error
    func save(onCompletion: @escaping (Error?) -> Void)
    
    /// Fetches managed objects with provided entity and predicate details
    ///
    /// - Important:
    ///     - Retruns result on the caller thread
    ///
    /// - Parameter:
    ///     - entity: Managed object type
    ///     - with: predicate (used for filtering)
    ///     - onCompletion: Closure, executed after success/failed fetch operation with any possible error or managed objects
    func fetch<ManagedObject: NSManagedObject>(entity: ManagedObject.Type,
                                               with predicate: NSPredicate?,
                                               onCompletion: @escaping ([NSManagedObject]?, Error?) -> Void)
    
    /// Deletes managed objects
    ///
    /// - Important:
    ///     - Retruns result on the caller thread
    ///
    /// - Parameter:
    ///     - managedObject: maching object type, that needs to be deleted
    ///     - onCompletion: Closure, executed after success/failed fetch operation with any possible error
    func delete(managedObject: NSManagedObject,
                onCompletion: @escaping (Error?) -> Void)
    
}
