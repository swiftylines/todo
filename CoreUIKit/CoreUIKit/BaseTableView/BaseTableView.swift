//
//  BaseTableView.swift
//  CoreUIKit
//
//  Created by Manish on 02/09/21.
//

import UIKit

/// A view replacing direct use of `UITableView` with added features.
public class BaseTableView: UITableView {
    
    public init(with pullToRefresh: Bool = false) {
        super.init(frame: .zero, style: .plain)
        
        self.bounces = pullToRefresh
        self.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Register and Dequeue cells
public extension BaseTableView {
    
    /// Registeres provided cell type with current `BaseTableView` instance
    /// - Parameter cellType: type of `UITableViewCell`, that needs to be registered
    func register<CellType: UITableViewCell>(_ cellType: CellType.Type) {
        self.register(cellType,
                      forCellReuseIdentifier: String(describing: cellType))
    }
    
    /// Dequeues reusable registered cell type
    /// - Parameter cellType: type of `UITableViewCell`, that needs to be dequeued
    /// - Returns: Cell instance, if it was regstered or `nil`
    func dequeue <CellType: UITableViewCell>(_ cellType: CellType.Type) -> CellType? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType)) as? CellType
    }
    
    /// Dequeues reusable registered cell type
    /// - Parameters:
    ///   - cellType: type of `UITableViewCell`, that needs to be dequeued
    ///   - indexPath: dequeue for position
    /// - Returns: Cell instance, if it was regstered or `nil`
    func dequeue <CellType: UITableViewCell>(_ cellType: CellType.Type,
                                             for indexPath: IndexPath) -> CellType? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType),
                                        for: indexPath) as? CellType
    }
    
}
