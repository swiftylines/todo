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
    private lazy var textView = UITextView()
    private(set) var viewModel: AddToDoViewModel?
    
    
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
        self.textView
            .add(to: self.view)
            .allAnchorsSame(on: self.view)
        
        self.textView.delegate = self
    }
    
    func setupData() {
        
    }
    
}

extension AddToDoView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.isEmpty ? "Yes" : "No")
    }
    
}
