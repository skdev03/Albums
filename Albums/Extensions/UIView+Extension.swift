//
//  UIView+Extension.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat,
                topPriority: UILayoutPriority = .defaultHigh, leftPriority: UILayoutPriority = .defaultHigh, bottomPriority: UILayoutPriority = .defaultHigh, rightPriority: UILayoutPriority = .defaultHigh,
                width: CGFloat = 0, height: CGFloat = 0, enableInsets: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if enableInsets {
            let insets = safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
        }
        
        if let top = top {
            let topAnchorConstraint = topAnchor.constraint(equalTo: top, constant: topPadding + topInset)
            topAnchorConstraint.priority = topPriority
            topAnchorConstraint.isActive = true
        }
        
        if let left = left {
            let leftAnchorConstraint = leftAnchor.constraint(equalTo: left, constant: leftPadding)
            leftAnchorConstraint.priority = leftPriority
            leftAnchorConstraint.isActive = true
        }
        
        if let bottom = bottom {
            let bottomAnchorConstraint = bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding - bottomInset)
            bottomAnchorConstraint.priority = bottomPriority
            bottomAnchorConstraint.isActive = true
        }
        
        if let right = right {
            let rightAnchorConstraint = rightAnchor.constraint(equalTo: right, constant: -rightPadding)
            rightAnchorConstraint.priority = rightPriority
            rightAnchorConstraint.isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
