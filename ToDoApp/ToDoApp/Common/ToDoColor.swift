//
//  ToDoColor.swift
//  ToDoApp
//
//  Created by Manish on 03/10/21.
//

import UIKit

enum ToDoColor {
    
    case primaryText
    case secondaryText
    
    var color: UIColor? {
        switch self {
        case .primaryText:
            return UIColor.rgba(r: 17, g: 32, b: 49)
        case .secondaryText:
            return UIColor.rgba(r: 21, g: 45, b: 53)
        }
    }
    
}

extension UIColor {
    
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
}
