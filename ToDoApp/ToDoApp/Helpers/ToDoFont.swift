//
//  ToDoFont.swift
//  ToDoApp
//
//  Created by Manish on 03/10/21.
//

import UIKit

enum ToDoFont {
    
    case bold
    case boldItalic
    case italic
    case regular
    
    var fontName: String {
        switch self {
        case .bold:
            return "NotoSans-Bold"
        case .boldItalic:
            return "NotoSans-BoldItalic"
        case .italic:
            return "NotoSans-Italic"
        case .regular:
            return "NotoSans-Regular"
        }
    }
    
    func with(size: CGFloat) -> UIFont? {
        return UIFont.loadFont(with: self.fontName, fontSize: size)
    }
    
}

extension UIFont {
    
    static func loadFont(with name: String, fontSize: CGFloat) -> UIFont? {
        guard let customFont = UIFont(name: name, size: fontSize) else {
            assertionFailure()
            return nil
        }
        
        return customFont
    }
    
}
