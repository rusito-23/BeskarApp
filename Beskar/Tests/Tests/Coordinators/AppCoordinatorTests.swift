//
//  AppCoordinatorTests.swift
//  Beskar
//
//  Created by Igor on 07/02/2021.
//

import XCTest
import Nimble
import BeskarKit
@testable import Beskar

final class AppCoordinatorTests: XCTestCase {

    // MARK: Properties

    private var authServiceMock: AuthServiceMock!
    private var navigationMock: NavigationControllerMock!
    private var coordinator: AppCoordinator!

    // MARK: Setup

    override func setUp() {
        navigationMock = NavigationControllerMock()
        authServiceMock = AuthServiceMock()
        injector.register(AuthServiceProtocol.self) { _ in self.authServiceMock }
        coordinator = AppCoordinator(presenter: navigationMock)
    }

    // MARK: Tests

    func test_onFirstLaunch_shouldStartWelcomeFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = false

        // Start coordinator
        coordinator.start()

        // Check last presented
        let presented = navigationMock.lastPresentedViewController
        expect(presented).to(beAKindOf(WelcomeViewController.self))
    }

    func test_notOnFirstLaunch_shouldStartLoginFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.pushExpectation = expectation(description: "Push Main Flow")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")
        authServiceMock.authenticationExpectation = expectation(description: "Authentication")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .success(true)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        let pushed = navigationMock.lastPushedViewController
        expect(pushed).to(beAKindOf(UITabBarController.self))
    }

    func test_withAuthServiceNotAvailable_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = false

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        let presented = navigationMock.lastPresentedViewController
        expect(presented).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationUnavailable_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.unavailable)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        let presented = navigationMock.lastPresentedViewController
        expect(presented).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationCanceled_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.canceled)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        let presented = navigationMock.lastPresentedViewController
        expect(presented).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationFailure_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.unauthorized)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        let presented = navigationMock.lastPresentedViewController
        expect(presented).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationPartialFailure_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .success(false)

        // Start coordinator
        coordinator.start()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        let presented = navigationMock.lastPresentedViewController
        expect(presented).to(beAKindOf(ErrorViewController.self))
    }

    func test_welcomeCoordinatorDidStop_shouldStartLoginFlow() {
        let welcomeCoordinator = WelcomeCoordinator()
        coordinator.coordinatorDidStop(welcomeCoordinator)

        expect(self.coordinator.children)
            .to(containElementSatisfying {$0 is LoginCoordinator})
    }

    func test_authErrorCoordinatorDidStop_shouldStartLoginFlow() {
        let authErrorCoordinator = AuthErrorCoordinator(error: .canceled)
        coordinator.coordinatorDidStop(authErrorCoordinator)

        expect(self.coordinator.children)
            .to(containElementSatisfying {$0 is LoginCoordinator})
    }

    func test_otherCoordinatorDidStop_shouldNotStartLoginFlow() {
        let otherCoordinator = BaseCoordinator()
        coordinator.coordinatorDidStop(otherCoordinator)

        expect(self.coordinator.children)
            .notTo(containElementSatisfying {$0 is LoginCoordinator})
    }
}
