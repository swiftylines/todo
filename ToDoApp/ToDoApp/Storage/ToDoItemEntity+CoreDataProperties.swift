//
//  ToDoItemEntity+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Manish on 02/10/21.
//
//

import Foundation
import CoreData


extension ToDoItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItemEntity> {
        return NSFetchRequest<ToDoItemEntity>(entityName: "ToDoItemEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var createdAt: Date
    @NSManaged public var descText: String

}
