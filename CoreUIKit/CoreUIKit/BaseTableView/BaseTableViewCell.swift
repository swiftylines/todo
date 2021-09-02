//
//  BaseTableViewCell.swift
//  CoreUIKit
//
//  Created by Manish on 02/09/21.
//

import UIKit

public class BaseTableViewCell: UITableViewCell, BaseView {
    
    public var viewModel: BaseViewModel?
    
    public func setupViews() {
        self.selectionStyle = .none
    }
    
    public func setupData() {
        
    }
    
    
}
