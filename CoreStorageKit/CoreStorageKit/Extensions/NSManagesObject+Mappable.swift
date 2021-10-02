//
//  NSManagesObject+Mappable.swift
//  CoreStorageKit
//
//  Created by Manish on 26/09/21.
//

import Foundation
import CoreData

extension NSManagedObject: ManagedObjectMappable {
    
    public func map<Element>() -> [Element] {
        assertionFailure("Must be implemented and don't call `super.map`")
        return []
    }
    
}
