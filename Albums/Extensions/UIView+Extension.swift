//
//  UIView+Extension.swift
//  Albums
//
//  Created by Sujan Kanna on 5/29/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, topPadding: CGFloat,
                left: NSLayoutXAxisAnchor?, leftPadding: CGFloat,
                bottom: NSLayoutYAxisAnchor?, bottomPadding: CGFloat,
                right: NSLayoutXAxisAnchor?, rightPadding: CGFloat,
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
            topAnchor.constraint(equalTo: top, constant: topPadding + topInset).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding - bottomInset).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
