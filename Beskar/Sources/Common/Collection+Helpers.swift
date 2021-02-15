//
//  Collection+Helpers.swift
//  Beskar
//
//  Created by Igor on 31/01/2021.
//

import Foundation

// MARK: - Nil Or Empty

extension Optional where Wrapped: Collection {
    /// Performs `nil` and `empty` checks
    var isNilOrEmpty: Bool { self?.isEmpty ?? true }

    /// Unwraps if not empty - or return `nil`
    var nonEmptyUnwrapped: Self {
        isNilOrEmpty ? nil : self
    }
}

extension Collection {
    /// `~isEmpty` that's all...
    var isNotEmpty: Bool { !isEmpty }
}

// MARK: - Safe Subscript

extension Collection {

    /// Returns the element at the given index
    /// If the index is out of bounds, returns `nil`
    subscript(safe index: Self.Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
