//
//  ToDoListViewModelDelegate.swift
//  ToDoApp
//
//  Created by Manish on 04/09/21.
//

import Foundation

protocol ToDoListViewModelDelegate: AnyObject {
    func didUpdateToDos()
    func shouldShowError(with text: String)
}
