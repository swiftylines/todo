//
//  UIVIew+Constraints.swift
//  CoreUIKit
//
//  Created by Manish on 03/09/21.
//

import UIKit

// MARK: - Add
public extension UIView {
    
    /// Adds current view to provided parent view (if it's not already added)
    /// - Parameter parentView: a view on which current view (child view) needs to be added
    /// - Returns: current view
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
    
    /// Sets leading, trailing, top and bottom anchors equal to parent view's anchors
    /// - Parameters:
    ///   - parentView: a view on which current view (child view) needs to be constrained
    ///   - margin: margin around the constraints
    /// - Returns: current view
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
    
    /// Sets leading anchor of the current view to provided anchor
    /// - Parameters:
    ///   - anchor: anchor value, which will be applied as leading anchor on current view
    ///   - margin: leading margin / left margin from current view
    /// - Returns: current view
    @discardableResult
    func leading(with anchor: NSLayoutXAxisAnchor,
                 margin: CGFloat = .zero) -> Self {
        self.leadingAnchor
            .constraint(equalTo: anchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    /// Sets trailing anchor of the current view to provided anchor
    /// - Parameters:
    ///   - anchor: anchor value, which will be applied as trailing anchor on current view
    ///   - margin: trailing margin / right margin from current view
    /// - Returns: current view
    @discardableResult
    func trailing(with anchor: NSLayoutXAxisAnchor,
                  margin: CGFloat = .zero) -> Self {
        self.trailingAnchor
            .constraint(equalTo: anchor,
                        constant: -margin).isActive = true
        
        return self
    }
    
    /// Sets top anchor of the current view to provided anchor
    /// - Parameters:
    ///   - anchor: anchor value, which will be applied as top anchor on current view
    ///   - margin: top margin from current view
    /// - Returns: current view
    @discardableResult
    func top(with anchor: NSLayoutYAxisAnchor,
             margin: CGFloat = .zero) -> Self {
        self.topAnchor
            .constraint(equalTo: anchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    /// Sets bottom anchor of the current view to provided anchor
    /// - Parameters:
    ///   - anchor: anchor value, which will be applied as bottom anchor on current view
    ///   - margin: bottom margin from current view
    /// - Returns: current view
    @discardableResult
    func bottom(with anchor: NSLayoutYAxisAnchor,
                margin: CGFloat = .zero) -> Self {
        self.bottomAnchor
            .constraint(equalTo: anchor,
                        constant: -margin).isActive = true
        
        return self
    }
    
    /// Sets width and heoght anchor with given value on current view
    /// - Parameters:
    ///   - width: width value
    ///   - height: height value
    /// - Returns: current view
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
    
    /// Sets centerX anchor of the current view to provided anchor
    /// - Parameters:
    ///   - anchor: anchor value, which will be applied as centerX anchor on current view
    ///   - margin: margin from current view on X-axis
    /// - Returns: current view
    @discardableResult
    func centerX(with anchor: NSLayoutXAxisAnchor,
                 margin: CGFloat = .zero) -> Self {
        self.centerXAnchor
            .constraint(equalTo: anchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    /// Sets centerY anchor of the current view to provided anchor
    /// - Parameters:
    ///   - anchor: anchor value, which will be applied as centerY anchor on current view
    ///   - margin: margin from current view on Y-axis
    /// - Returns: current view
    @discardableResult
    func centerY(with anchor: NSLayoutYAxisAnchor,
                 margin: CGFloat = .zero) -> Self {
        self.centerYAnchor
            .constraint(equalTo: anchor,
                        constant: margin).isActive = true
        
        return self
    }
    
    /// Sets center (X & Y) anchor of the current view to provided anchor
    /// - Parameters:
    ///   - anchor: anchor value, which will be applied as centerX & centerY anchor on current view
    ///   - size: with and height value for current view
    /// - Returns: current view
    @discardableResult
    func center(on parentView: UIView,
                with size: CGSize) -> Self {
        self.centerX(with: parentView.centerXAnchor)
            .centerY(with: parentView.centerYAnchor)
            .with(width: size.width, height: size.height)
        
        return self
    }
    
}
