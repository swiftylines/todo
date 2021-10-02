//
//  ManagedObjectMappable.swift
//  CoreStorageKit
//
//  Created by Manish on 26/09/21.
//

import Foundation
import CoreData

/// Provides mapper for `NSManagedObject` to map into data model
public protocol ManagedObjectMappable: AnyObject {
    
    /// Maps `NSManagedObject` into data model
    /// - Returns: generic data model array
    func map<Element>() -> [Element]
    
}

extension ManagedObjectMappable where Self: NSManagedObject { }
