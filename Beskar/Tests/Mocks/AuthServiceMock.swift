//
//  AuthServiceMock.swift
//  BeskarTests
//
//  Created by Igor on 07/02/2021.
//

import BeskarKit
import XCTest

/// A mock class to control the auth service behavior

final class AuthServiceMock: AuthServiceProtocol {

    // MARK: Mock Properties

    var isAvailableMock: Bool = false
    var authenticationSuccessMock: Result<Bool, AuthService.AuthError> = .failure(.unavailable)

    // MARK: Expectations

    var availabilityExpectation: XCTestExpectation?
    var authenticationExpectation: XCTestExpectation?

    // MARK: Protocol Conformance

    func isAvailable() -> Bool {
        availabilityExpectation?.fulfill()
        return isAvailableMock
    }

    func authenticate(
        reason: String,
        completion: @escaping AuthService.Completion
    ) {
        authenticationExpectation?.fulfill()
        completion(authenticationSuccessMock)
    }
}
