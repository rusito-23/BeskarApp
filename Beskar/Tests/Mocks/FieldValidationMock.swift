//
//  FieldValidationMock.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

@testable import Beskar

final class FieldValidationMock: FieldValidationProtocol {

    // MARK: Properties

    var isValid: Bool = false

    // MARK: Conformance

    var failureMessage: String { "Error Message" }

    func eval(string: String?) -> Bool {
        return isValid
    }
}
