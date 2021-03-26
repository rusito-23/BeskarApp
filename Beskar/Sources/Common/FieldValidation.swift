//
//  FieldValidation.swift
//  Beskar
//
//  Created by Igor on 31/01/2021.
//

import Foundation

// MARK: - Field Validation Protocol

protocol FieldValidationProtocol {
    var failureMessage: String { get }
    func eval(string: String?) -> Bool
}

// MARK: - Field Validation

/// Field Validation
/// Provides a simple enum and methods with logic to validate different fields and avoid duplications
enum FieldValidation: FieldValidationProtocol {
    case minimumCharacterCount(min: Int, trim: Bool)
    case maximumCharacterCount(max: Int, trim: Bool)
    case isNotEmpty
    case regex(regex: Regex, trim: Bool)

    /// Regex validations
    enum Regex: String {
        case onlyUppercasedLetters = "[A-Z ]*"
        case startsWithUppercase = "[A-Z].*"
    }

    /// The localized failure message
    var failureMessage: String {
        switch self {
        case let .minimumCharacterCount(min, _): return "VALIDATION_MIN_FORMAT".localize(min)
        case let .maximumCharacterCount(max, _): return "VALIDATION_MAX_FORMAT".localize(max)
        case .isNotEmpty: return "VALIDATION_REQUIRED".localized
        case let .regex(regexValidation, _):
            switch regexValidation {
            case .onlyUppercasedLetters: return "VALIDATION_ALL_UPPERCASE".localized
            case .startsWithUppercase: return "VALIDATION_START_UPPERCASE".localized
            }
        }
    }

    /// Evaluate a given string
    func eval(string: String?) -> Bool {
        guard var string = string else { return false }

        let shouldTrim: Bool = {
            switch self {
            case let .minimumCharacterCount(_, trim),
                 let .maximumCharacterCount(_, trim),
                 let .regex(_, trim):
                return trim
            default: return true
            }
        }()

        string = shouldTrim ? string.trimmed : string

        switch self {
        case let .minimumCharacterCount(min, _): return string.count >= min
        case let .maximumCharacterCount(max, _): return string.count <= max
        case .isNotEmpty: return string.trimmed.isNotEmpty
        case let .regex(regexValidation, _):
            return NSPredicate(
                format: "SELF MATCHES %@",
                regexValidation.rawValue
            ).evaluate(with: string)
        }
    }
}
