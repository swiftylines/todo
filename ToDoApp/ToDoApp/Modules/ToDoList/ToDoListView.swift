//
//  ToDoListView.swift
//  ToDoApp
//
//  Created by Manish on 02/09/21.
//

import UIKit
import CoreUIKit

class ToDoListView: UIViewController, BaseInitializableView {
    let viewModel: BaseViewModel?
    
    required init(viewModel: BaseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    func setupViews() {
        
    }
    
    func setupData() {
        
    }
    
}
