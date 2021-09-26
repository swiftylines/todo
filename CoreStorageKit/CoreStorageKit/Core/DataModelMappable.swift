//
//  DataModelMappable.swift
//  CoreStorageKit
//
//  Created by Manish on 26/09/21.
//

import Foundation
import CoreData

/// Provides mapper for data models
public protocol DataModelMappable {
    
    /// Maps data model in to `NSManagedObject`, which can be used to for core data operations
    /// - Returns: `NSManagedObject`
    func map(from context: NSManagedObjectContext) -> NSManagedObject
    
}
