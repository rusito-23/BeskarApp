//
//  FieldValidation.swift
//  Beskar
//
//  Created by Igor on 31/01/2021.
//

import Foundation

/// Field Validation
/// Provides a simple enum and methods with logic to validate different fields and avoid duplications
enum FieldValidation {
    case minimumCharacterCount(Int)
    case maximumCharacterCount(Int)
    case isNotEmpty
    case regex(Regex)

    /// Regex validations
    enum Regex: String {
        case onlyUppercasedLetters = "[A-Z ]*"
        case startsWithUppercase = "[A-Z].*"
    }

    /// The localized failure message
    var failureMessage: String {
        switch self {
        case let .minimumCharacterCount(min): return "VALIDATION_MIN_FORMAT".localize(min)
        case let .maximumCharacterCount(max): return "VALIDATION_MAX_FORMAT".localize(max)
        case .isNotEmpty: return "VALIDATION_REQUIRED".localized
        case let .regex(regexValidation):
            switch regexValidation {
            case .onlyUppercasedLetters: return "VALIDATION_ALL_UPPERCASE".localized
            case .startsWithUppercase: return "VALIDATION_START_UPPERCASE".localized
            }
        }
    }

    /// Evaluate a given string
    func eval(string: String?) -> Bool {
        guard let string = string else { return false }

        switch self {
        case let .minimumCharacterCount(min): return string.count > min
        case let .maximumCharacterCount(max): return string.count <= max
        case .isNotEmpty: return string.trimmed.isNotEmpty
        case let .regex(regexValidation):
            return NSPredicate(
                format: "SELF MATCHES %@",
                regexValidation.rawValue
            ).evaluate(with: string)
        }
    }
}
