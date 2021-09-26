//
//  CoreStorageProviderError.swift
//  CoreStorageKit
//
//  Created by Manish on 25/09/21.
//

import Foundation

enum CoreStorageProviderError: Error {
    
    case managedObjectContextNil
    case persistentContainerNil
    case persistentDescriptionNil
    case persistentCoordinatorNil
    case loadingPersistentStoresFailed(Error?)
    case savingFailed(Error?)
    case fetchingFailed(Error?)
    case deletingFailed(Error?)
    
}
