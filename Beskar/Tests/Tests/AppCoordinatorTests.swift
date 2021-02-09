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
        XCTAssert(navigationMock.lastPresentedViewController is WelcomeViewController)
    }

    func test_notOnFirstLaunch_shouldStartLoginFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Login Flow")
        authMock.availabilityExpectation = expectation(description: "Check Auth Availability")
        authMock.authenticationExpectation = expectation(description: "Check Auth Authentication")

        // Setup mock responses
        authMock.isAvailableMock = true
        authMock.authenticationSuccessMock = .success(true)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(navigationMock.lastPresentedViewController is MainTabBarController)
    }

    func test_withAuthServiceNotAvailable_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        authMock.availabilityExpectation = expectation(description: "Check Auth Availability")

        // Setup mock responses
        authMock.isAvailableMock = false

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(navigationMock.lastPresentedViewController is ErrorViewController)
    }

    func test_onAuthenticationUnavailable_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authMock.availabilityExpectation = expectation(description: "Check Auth Availability")

        // Setup mock responses
        authMock.isAvailableMock = true
        authMock.authenticationSuccessMock = .failure(.unavailable)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(navigationMock.lastPresentedViewController is ErrorViewController)
    }

    func test_onAuthenticationCanceled_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authMock.availabilityExpectation = expectation(description: "Check Auth Availability")

        // Setup mock responses
        authMock.isAvailableMock = true
        authMock.authenticationSuccessMock = .failure(.canceled)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(navigationMock.lastPresentedViewController is ErrorViewController)
    }

    func test_onAuthenticationFailure_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authMock.availabilityExpectation = expectation(description: "Check Auth Availability")

        // Setup mock responses
        authMock.isAvailableMock = true
        authMock.authenticationSuccessMock = .failure(.unauthorized)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        XCTAssert(navigationMock.lastPresentedViewController is ErrorViewController)
    }
}
