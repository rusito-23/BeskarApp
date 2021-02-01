//
//  Collection+Helpers.swift
//  Beskar
//
//  Created by Igor on 31/01/2021.
//

import Foundation

// MARK: - Nil Or Empty

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}
