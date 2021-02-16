//
//  UIView+Helpers.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import UIKit

extension UIView {
    /// Add variadic subviews
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension UIView {
    /// Set Compression Resistance Priority and return `self`
    func withCompressionResistance(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) -> Self {
        setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

    /// Set Hugging Priority and return `self`
    func withHugging(
        _ priority: UILayoutPriority,
        for axis: NSLayoutConstraint.Axis
    ) -> Self {
        setContentHuggingPriority(priority, for: axis)
        return self
    }
}
