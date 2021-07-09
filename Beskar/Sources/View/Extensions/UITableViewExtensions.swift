//
//  UITableViewExtensions.swift
//  Beskar
//
//  Created by Igor on 14/02/2021.
//

import UIKit

// MARK: - UITableView Extensions

extension UITableView {

    /// Register cell using default identifier implementation
    func register(_ type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.identifier)
    }

    /// Safe dequeue a Table View Cell
    func dequeue<T: UITableViewCell>(_ type: T.Type) -> T? {
        dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
}

// MARK: - UICollectionView Extensions

extension UICollectionView {

    /// Register cell using default identifier implementation
    func register(_ type: UICollectionViewCell.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }

    /// Safe dequeue a Collection View Cell
    func dequeue<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
}
