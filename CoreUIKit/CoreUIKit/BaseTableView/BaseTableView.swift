//
//  BaseTableView.swift
//  CoreUIKit
//
//  Created by Manish on 02/09/21.
//

import UIKit

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

public extension BaseTableView {
    
    func register<CellType: UITableViewCell>(_ cellType: CellType.Type) {
        self.register(cellType,
                      forCellReuseIdentifier: String(describing: cellType))
    }
    
    func dequeue <CellType: UITableViewCell>(_ cellType: CellType.Type) -> CellType? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType)) as? CellType
    }
    
    func dequeue <CellType: UITableViewCell>(_ cellType: CellType.Type,
                                             for indexPath: IndexPath) -> CellType? {
        return self.dequeueReusableCell(withIdentifier: String(describing: cellType),
                                        for: indexPath) as? CellType
    }
    
}
