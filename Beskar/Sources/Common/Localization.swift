//
//  String+Localization.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import Foundation

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
