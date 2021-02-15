//
//  UITableViewExtensions.swift
//  Beskar
//
//  Created by Igor on 14/02/2021.
//

import UIKit

extension UITableView {

    /// Register cell using default identifier implementation
    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
}
