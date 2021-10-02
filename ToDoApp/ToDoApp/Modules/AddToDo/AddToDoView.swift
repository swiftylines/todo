//
//  AddToDoView.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import UIKit
import CoreUIKit

class AddToDoView: UIViewController, BaseInitializableView, AddToDoViewProvider {
    
    // MARK: - Properties
    private(set) var viewModel: AddToDoViewModel?
    
    // MARK: - Views
    let textView = PlaceholderTextView(placeholderText: "Type something...",
                                       textFont: ToDoFont.bold.with(size: 23),
                                       textColor: ToDoColor.primaryText.color)
    
    let saveToDoButtonView = UIBarButtonItem()
    
    // MARK: - Callbacks
    var onNewToDoSave: ((ToDoItem) -> Void)?
    
    
    // MARK: - Init
    required init(viewModel: AddToDoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add New ToDo"
        
        self.setupViews()
        self.setupData()
    }
    
    // MARK: - setups
    func setupViews() {
        self.setupTextView()
        self.checkAndSetupSaveToDoButtonVIew()
    }
    
    func setupData() {
        
    }
    
    func setupTextView() {
        self.textView
            .add(to: self.view)
            .allAnchorsSame(on: self.view)
        
        self.textView.onTextChange = { _ in
            self.checkAndSetupSaveToDoButtonVIew()
        }
    }
    
    func checkAndSetupSaveToDoButtonVIew() {
        if textView.text.isEmpty {
            self.navigationItem.rightBarButtonItem = nil
            return
        }
        
        if self.navigationItem.rightBarButtonItem == nil {
            self.setupSaveTodoButtonView()
        }
    }
    
    func setupSaveTodoButtonView() {
        self.saveToDoButtonView.title = "Save"
        self.saveToDoButtonView.target = self
        self.saveToDoButtonView.action = #selector(self.didTapSaveToDoButtonView)
        self.saveToDoButtonView.style = .plain
        
        self.navigationItem.rightBarButtonItem = self.saveToDoButtonView
    }
    
}

extension AddToDoView {
    
    func textViewDidChange(_ textView: UITextView) {
        self.checkAndSetupSaveToDoButtonVIew()
    }
    
}

// MARK: - Helpers
extension AddToDoView {
    
    @objc private func didTapSaveToDoButtonView() {
        
        self.viewModel?
            .tryCreatingNewToDo(with: self.textView.text, onResponse: { todoItem, error in
                
                guard let safeToDoItem = todoItem, error == nil else {
                    assertionFailure()
                    return
                }
                
                DispatchQueue.main.async {
                    self.onNewToDoSave?(safeToDoItem)
                    self.navigationController?.popViewController(animated: true)
                }
                
            })
        
    }
    
}
