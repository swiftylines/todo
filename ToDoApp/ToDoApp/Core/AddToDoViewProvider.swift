//
//  AddToDoViewProvider.swift
//  ToDoApp
//
//  Created by Manish on 18/09/21.
//

import UIKit

protocol AddToDoViewProvider {
    
    var viewModel: AddToDoViewModel? { get }
    
    var textView: UITextView { get }
    var saveToDoButtonView: UIBarButtonItem { get }
    
    var onNewToDoSave: ((ToDoItem) -> Void)? { get set }
    
    func setupTextView()
    func checkAndSetupSaveToDoButtonVIew()
    func setupSaveTodoButtonView()
}
