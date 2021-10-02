//
//  TestToDoEntity+CoreDataProperties.swift
//  CoreStorageKitTests
//
//  Created by Manish on 27/09/21.
//
//

import Foundation
import CoreData


extension TestToDoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestToDoEntity> {
        return NSFetchRequest<TestToDoEntity>(entityName: "TestToDoEntity")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var id: UUID
    @NSManaged public var text: String

}
