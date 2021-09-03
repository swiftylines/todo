//
//  UIVIew+Constraints.swift
//  CoreUIKit
//
//  Created by Manish on 03/09/21.
//

import UIKit

// MARK: - Add
public extension UIView {
    
    @discardableResult
    func add(to parentView: UIView) -> Self {
        if self.isDescendant(of: parentView) {
            return self
        }
        
        // Add
        parentView.addSubview(self)
        
        // Enable constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return self
    }
    
}

// MARK: - Constraints
public extension UIView {
    
    @discardableResult
    func allAnchorsSame(on parentView: UIView,
                        margin: UIEdgeInsets = .zero) -> Self {
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: margin.left),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: margin.right),
            self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: margin.top),
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: margin.bottom)
        ])
        
        return self
    }
    
    @discardableResult
    func leading(on parentView: UIView,
                 margin: CGFloat = .zero) -> Self {
        self.leadingAnchor
            .constraint(equalTo: parentView.leadingAnchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    @discardableResult
    func trailing(on parentView: UIView,
                  margin: CGFloat = .zero) -> Self {
        self.trailingAnchor
            .constraint(equalTo: parentView.trailingAnchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    @discardableResult
    func top(on parentView: UIView,
             margin: CGFloat = .zero) -> Self {
        self.topAnchor
            .constraint(equalTo: parentView.topAnchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    @discardableResult
    func bottom(on parentView: UIView,
                margin: CGFloat = .zero) -> Self {
        self.bottomAnchor
            .constraint(equalTo: parentView.bottomAnchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    @discardableResult
    func with(width: CGFloat? = nil,
              height: CGFloat? = nil) -> Self {
        
        if let safeWidth = width {
            self.widthAnchor
                .constraint(equalToConstant: safeWidth)
                .isActive = true
        }
        
        if let safeHeight = height {
            self.heightAnchor
                .constraint(equalToConstant: safeHeight)
                .isActive = true
        }
        
        return self
    }
    
    @discardableResult
    func centerX(on parentView: UIView,
                 margin: CGFloat = .zero) -> Self {
        self.centerXAnchor
            .constraint(equalTo: parentView.centerXAnchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    @discardableResult
    func centerY(on parentView: UIView,
                 margin: CGFloat = .zero) -> Self {
        self.centerYAnchor
            .constraint(equalTo: parentView.centerYAnchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    @discardableResult
    func center(on parentView: UIView,
                with size: CGSize) -> Self {
        self.centerX(on: parentView)
            .centerY(on: parentView)
            .with(width: size.width, height: size.height)
        
        return self
    }
    
}
