//
//  ToDoItemCell.swift
//  ToDoApp
//
//  Created by Manish on 04/09/21.
//

import UIKit
import CoreUIKit

class ToDoItemCell: BaseTableViewCell<ToDoItemCellViewModel> {
    
    // MARK: - Properties
    private let verticalMargin: CGFloat = 10
    private let horizontalMargin: CGFloat = 20
    
    // MARK: - Views
    private let todoDescriptionLabel = ToDoLabel.primary.create()
    private let todoTimeLabel = ToDoLabel.secondary.create()
    private let dividerView = UIView()
    
    // MARK: - Setups
    override func setupViews() {
        super.setupViews()
        
        self.todoDescriptionLabel
            .add(to: self.contentView)
            .top(with: self.contentView.topAnchor, margin: self.verticalMargin)
            .leading(with: self.contentView.leadingAnchor, margin: self.horizontalMargin)
            .trailing(with: self.contentView.trailingAnchor, margin: self.horizontalMargin)
        
        self.todoTimeLabel.textAlignment = .right
        self.todoTimeLabel
            .add(to: self.contentView)
            .top(with: self.todoDescriptionLabel.bottomAnchor, margin: self.verticalMargin / 2)
            .leading(with: self.contentView.leadingAnchor, margin: self.horizontalMargin)
            .trailing(with: self.contentView.trailingAnchor, margin: self.horizontalMargin)
            .bottom(with: self.contentView.bottomAnchor, margin: self.verticalMargin)
        
        self.dividerView.backgroundColor = .lightGray
        self.dividerView
            .add(to: self.contentView)
            .bottom(with: self.bottomAnchor)
            .leading(with: self.contentView.leadingAnchor, margin: self.horizontalMargin)
            .trailing(with: self.contentView.trailingAnchor, margin: self.horizontalMargin)
            .with(height: 0.5)
    }
    
    override func setupData() {
        super.setupData()
        
        self.todoDescriptionLabel.text = self.viewModel?.todoItem.description
        self.todoTimeLabel.text = self.viewModel?.todoItem.createdAt.description
    }
    
}
