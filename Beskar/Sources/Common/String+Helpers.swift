//
//  String+Helpers.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import Foundation

// MARK: - Localization

extension String {
    /// Localize without arguments
    var localized: String {
        NSLocalizedString(self, comment: self)
    }

    /// Localize string with format
    func localize(_ arguments: CVarArg...) -> String {
        String(format: self.localized, arguments)
    }
}

// MARK: - Trim Helpers

extension String {
    var trimmed: String { trimmingCharacters(in: .whitespaces) }
}
