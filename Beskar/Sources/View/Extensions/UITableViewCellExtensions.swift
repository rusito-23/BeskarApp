//
//  UITableViewCellExtensions.swift
//  Beskar
//
//  Created by Igor on 14/02/2021.
//

import UIKit

extension UITableViewCell {

    /// Default cell identifier using class name
    static var identifier: String {
        String(describing: self)
    }
}
