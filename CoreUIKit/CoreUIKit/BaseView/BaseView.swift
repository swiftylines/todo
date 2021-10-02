//
//  BaseView.swift
//  CoreUIKit
//
//  Created by Manish on 02/09/21.
//

public protocol BaseView {
    
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel? { get }
    
    func setupViews()
    func setupData()
    
}
