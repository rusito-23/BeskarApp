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

    /// Localize with format (& arguments)
    func localize(_ args: CVarArg...) -> String {
        String(format: self.localized, arguments: args)
    }
}

// MARK: - Trim Helpers

extension String {
    var trimmed: String {
        trimmingCharacters(
            in: .whitespacesAndNewlines
        ).split(separator: " ")
        .map(String.init)
        .joined()
    }
}
