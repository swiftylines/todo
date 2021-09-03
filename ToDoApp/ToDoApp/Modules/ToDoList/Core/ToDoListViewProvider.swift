//
//  ToDoListViewProvider.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import UIKit
import CoreUIKit

protocol ToDoListViewProvider {
    
    var todoTableView: BaseTableView { get }
    var addToDoButtonView: UIButton { get }
    
    func setupTodoTableView()
    func setupAddTodoButtonView()
    
}
