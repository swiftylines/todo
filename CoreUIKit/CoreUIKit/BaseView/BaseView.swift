//
//  BaseView.swift
//  CoreUIKit
//
//  Created by Manish on 02/09/21.
//

public protocol BaseView {
    
    var viewModel: BaseViewModel? { get }
    
    func setupViews()
    func setupData()
    
}
