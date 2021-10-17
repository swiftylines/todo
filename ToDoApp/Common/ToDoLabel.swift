//
//  ToDoLabel.swift
//  ToDoApp
//
//  Created by Manish on 03/10/21.
//

import Foundation
import UIKit

enum ToDoLabel {
    
    case primary
    case secondary
    
    func create() -> UILabel {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        
        switch self {
        case .primary:
            lbl.font = ToDoFont.bold.with(size: 18)
            lbl.textColor = ToDoColor.primaryText.color
            return lbl
            
        case .secondary:
            lbl.font = ToDoFont.italic.with(size: 14)
            lbl.textColor = ToDoColor.secondaryText.color
            return lbl
        }
    }
    
}
