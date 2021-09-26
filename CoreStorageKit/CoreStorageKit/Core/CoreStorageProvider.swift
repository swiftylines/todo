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
    
    // MARK: - Init
    init(with coreDataModelName: String,
         onCompletion: @escaping (Error?) -> Void)
    
    // MARK: - Features
    func save(onCompletion: @escaping (Error?) -> Void)
    
    func fetch<ManagedObject: NSManagedObject>(entity: ManagedObject.Type,
                                               onCompletion: @escaping ([NSManagedObject]?, Error?) -> Void)
    
    func delete()
    
}
