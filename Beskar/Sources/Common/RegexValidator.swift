//
//  RegexValidator.swift
//  Beskar
//
//  Created by Igor on 31/01/2021.
//

import Foundation

struct RegexValidator {

    // MARK: - Types

    /// Different Regex kinds to eval using a predefined configuration
    enum Regex: String {
        /// A password should contain, at least:
        /// - one uppercase letter
        /// - one lowecase letter
        /// - one number
        /// - one symbol
        /// - have at least 8 characters
        case password = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
    }

    // MARK: - Static Methods

    /// Given a Regex Kind, evaluate the String
    static func eval(
        _ string: String,
        for regex: Regex,
        trim shouldTrim: Bool = false
    ) -> Bool {
        NSPredicate(
            format: "SELF MATCHES %@",
            regex.rawValue
        ).evaluate(
            with: shouldTrim ? string.trimmed : string
        )
    }
}
