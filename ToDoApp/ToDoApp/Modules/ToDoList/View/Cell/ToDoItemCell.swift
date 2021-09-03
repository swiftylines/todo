//
//  ToDoItemCell.swift
//  ToDoApp
//
//  Created by Manish on 04/09/21.
//

import UIKit
import CoreUIKit

class ToDoItemCell: BaseTableViewCell<ToDoItemCellViewModel> {
    
    private lazy var todoDescriptionLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        
        self.todoDescriptionLabel
            .add(to: self.contentView)
            .allAnchorsSame(on: self.contentView)
    }
    
    override func setupData() {
        super.setupData()
        
        self.todoDescriptionLabel.text = self.viewModel?.todoDescription
    }
    
}
