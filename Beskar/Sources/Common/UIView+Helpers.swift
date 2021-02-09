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
