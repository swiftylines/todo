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
    let todoTableView = BaseTableView()
    let addToDoButtonView = UIButton()
    let viewModel: ToDoListViewModel?
    
    // MARK: - Init
    required init(viewModel: ToDoListViewModel) {
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
        self.setupTodoTableView()
        self.setupAddTodoButtonView()
    }
    
    func setupData() {
        
    }
    
    func setupTodoTableView() {
        self.todoTableView
            .add(to: self.view)
            .allAnchorsSame(on: self.view)
        
        self.todoTableView
            .register(UITableViewCell.self)
        
        self.todoTableView.dataSource = self
        self.todoTableView.delegate = self
    }
    
    func setupAddTodoButtonView() {
        
    }
    
}
