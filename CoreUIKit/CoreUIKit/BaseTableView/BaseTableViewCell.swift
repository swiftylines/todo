//
//  BaseTableViewCell.swift
//  CoreUIKit
//
//  Created by Manish on 02/09/21.
//

import UIKit

open class BaseTableViewCell<ViewModel: BaseViewModel>: UITableViewCell, BaseView {
    
    public var viewModel: ViewModel? {
        didSet {
            self.setupData()
        }
    }
    
    open func setupViews() {
        self.selectionStyle = .none
    }
    
    open func setupData() {
        
    }
    
    
}
