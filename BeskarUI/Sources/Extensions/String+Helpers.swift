//
//  String+Helpers.swift
//  BeskarUI
//
//  Created by Igor on 21/03/2021.
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
