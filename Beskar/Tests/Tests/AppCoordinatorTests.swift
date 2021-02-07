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
    private var navigationMock: NavigationControllerMock!

    // MARK: Setup

    override func setUp() {
        navigationMock = NavigationControllerMock()
        authMock = AuthServiceMock()

        coordinator = AppCoordinator(
            presenter: navigationMock,
            authService: authMock
        )
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
        navigationMock.presentExpectation = expectation(description: "Should present Login Flow")
        authMock.availabilityExpectation = expectation(description: "Should Check Auth Availability")
        authMock.authenticationExpectation = expectation(description: "Should Check Auth Authentication")

        // Setup mock responses
        authMock.isAvailableMock = true
        authMock.authenticationSuccessMock = true

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(navigationMock.presentedViewController is TabViewController)
    }

    func test_withAuthServiceNotAvailable_shouldShowError() {
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

    func test_onAuthenticationError_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Should present Error")
        authMock.availabilityExpectation = expectation(description: "Should Check Auth Availability")

        // Setup mock responses
        authMock.isAvailableMock = true
        authMock.authenticationSuccessMock = false

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(coordinator.presenter.presentedViewController is ErrorViewController)
    }
}
