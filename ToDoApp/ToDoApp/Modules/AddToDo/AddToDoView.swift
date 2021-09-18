//
//  AddToDoView.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import UIKit
import CoreUIKit

class AddToDoView: UIViewController, BaseInitializableView {
    
    // MARK: - Properties
    private(set) var viewModel: AddToDoViewModel?
    private var todoHelper = ToDoListHelper.shared
    
    // MARK: - Views
    private lazy var textView = UITextView()
    private lazy var saveToDoButtonView = UIBarButtonItem()
    
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
        
        self.textView.delegate = self
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
    
    @objc private func didTapSaveToDoButtonView() {
        do {
            let addedToDoItem = try self.todoHelper.addNewToDo(with: self.textView.text)
            
            self.onNewToDoSave?(addedToDoItem)
            self.navigationController?.popViewController(animated: true)
        } catch {
            print(error)
            assertionFailure()
        }
        
    }
    
}

extension AddToDoView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.checkAndSetupSaveToDoButtonVIew()
    }
    
}
