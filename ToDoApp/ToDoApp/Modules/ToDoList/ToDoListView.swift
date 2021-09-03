//
//  ToDoListView.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import UIKit
import CoreUIKit

class ToDoListView: UIViewController, BaseInitializableView, ToDoListViewProvider {
    
    // MARK: - Properties
    let todoListView = BaseTableView()
    let addToDoButtonView = UIButton()
    let viewModel: BaseViewModel?
    
    // MARK: - Init
    required init(viewModel: BaseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupData()
    }
    
    // MARK: - Setups
    func setupViews() {
        self.setupTodoListView()
        self.setupAddTodoButtonView()
    }
    
    func setupData() {
        
    }
    
    func setupTodoListView() {
        self.todoListView
            .add(to: self.view)
            .allAnchorsSame(on: self.view)
    }
    
    func setupAddTodoButtonView() {
        
    }
    
}
