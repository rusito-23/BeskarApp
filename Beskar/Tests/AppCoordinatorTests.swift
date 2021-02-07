//
//  AppCoordinatorTests.swift
//  Beskar
//
//  Created by Igor on 07/02/2021.
//

import XCTest
import BeskarKit
@testable import Beskar

final class AppCoordinatorTests: XCTestCase {

    // MARK: Properties

    private var authMock: AuthServiceMock!
    private var coordinator: AppCoordinator!

    // MARK: Setup

    override func setUp() {
        authMock = AuthServiceMock()
        coordinator = AppCoordinator(authService: authMock)
    }

    // MARK: Tests

    func test_onFirstLaunch_shouldStartWelcomeFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = false

        // Start coordinator
        coordinator.start()

        // Check last presented
        XCTAssert(coordinator.presenter.presentedViewController is WelcomeViewController)
    }

    func test_notOnFirstLaunch_shouldStartLoginFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        authMock.availabilityExpectation = expectation(description: "Should Check Auth Availability")
        authMock.authenticationExpectation = expectation(description: "Should Check Auth Authentication")

        // Setup mock responses
        authMock.isAvailableMock = true
        authMock.authenticationSuccessMock = true

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
    }

    func test_withAuthNotAvailable_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        authMock.availabilityExpectation = expectation(description: "Should Check Auth Availability")

        // Setup mock responses
        authMock.isAvailableMock = false

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(coordinator.presenter.presentedViewController is ErrorViewController)
    }
}

// MARK: - Auth Service Mock

final class AuthServiceMock: AuthServiceProtocol {

    // MARK: Properties

    var isAvailableMock: Bool = false
    var authenticationSuccessMock: Bool = false

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
