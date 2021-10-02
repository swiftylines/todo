//
//  AppDelegate+SetupRootVC.swift
//  ToDoApp
//
//  Created by Manish on 03/10/21.
//

import UIKit
import CoreStorageKit

extension AppDelegate {
    
    func setupRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let todoListVM = ToDoListViewModel(todoStorageHelper: self.getToDoStorageHelperInstence())
        let toDoListVC = ToDoListView(viewModel: todoListVM)
        self.window?.rootViewController = UINavigationController(rootViewController: toDoListVC)
        self.window?.makeKeyAndVisible()
    }

    private func getToDoStorageHelperInstence() -> ToDoStorageHelper {
        let coreStorageManager = CoreStorageManager(with: "ToDoStorage",
                                                    coreDataModelBundle: Bundle(for: AppDelegate.self)) { err in
            if err != nil {
                assertionFailure(err.debugDescription)
            }
        }
        
        return ToDoStorageHelper(storageManager: coreStorageManager)
    }
    
}
