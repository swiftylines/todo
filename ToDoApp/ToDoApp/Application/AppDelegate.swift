//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupRootViewController()
        return true
    }

}

private extension AppDelegate {
    
    func setupRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: ToDoListView(viewModel: ToDoListViewModel()))
        self.window?.makeKeyAndVisible()
    }
    
}
