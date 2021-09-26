//
//  TestToDoEntity+CoreDataProperties.swift
//  CoreStorageKitTests
//
//  Created by Manish on 26/09/21.
//
//

import Foundation
import CoreData


extension TestToDoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestToDoEntity> {
        return NSFetchRequest<TestToDoEntity>(entityName: "TestToDoEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var createdAt: Date?

}

extension TestToDoEntity : Identifiable {

}
