//
//  StringValidator.swift
//  Beskar
//
//  Created by Igor on 31/01/2021.
//

import Foundation

// MARK: - Validation Kinds

/// Validation Kinds
///
/// # Discussion #
/// The Validation Kind defines two basic ways to validate a String:
/// - `regex` will have an associated `Regex` enum case, with an associated string, that will be evaluated
/// - `custom` will have an associated `Custom` enum case, that has an associated eval method with a custom implementation.
enum ValidationKind {
    case regex(_ regex: Regex)
    case custom(_ custom: Custom)

    /// Different custom evaluations
    enum Custom {
        case atLeast(Int)
        case atMost(Int)
        case notEmpty

        /// Custom evaluation implementation
        func eval(string: String) -> Bool {
            switch self {
            case let .atLeast(min): return string.count > min
            case let .atMost(max): return string.count <= max
            case .notEmpty: return string.trimmed.isNotEmpty
            }
        }
    }

    /// Different Regex kinds to eval using a predefined configuration
    enum Regex: String {
        case onlyUppercasedLetters = "[A-Z ]*"
        case startsWithUppercase = "[A-Z].*"

        /// Custom evaluation implementation
        func eval(string: String) -> Bool {
            return NSPredicate(
                format: "SELF MATCHES %@", self.rawValue
            ).evaluate(with: string)
        }
    }

    /// Evaluation implementation
    func eval(string: String) -> Bool {
        switch self {
        case let .custom(customValidation):
            return customValidation.eval(string: string)
        case let .regex(pattern):
            return pattern.eval(string: string)
        }
    }
}

// MARK: - Validator Protocol

protocol StringValidatorProtocol {
    /// Given a `ValidationKind`, evaluate the String
    func eval(
        _ string: String,
        for validationKind: ValidationKind
    ) -> Bool
}

// MARK: - Validator Implementation

struct StringValidator: StringValidatorProtocol {
    func eval(
        _ string: String,
        for validationKind: ValidationKind
    ) -> Bool {
        validationKind.eval(string: string)
    }
}
