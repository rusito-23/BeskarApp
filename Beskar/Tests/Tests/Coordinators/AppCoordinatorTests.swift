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

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(WelcomeViewController.self))
    }

    func test_notOnFirstLaunch_shouldStartLoginFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true
        Preferences.authMinutesTimeout = 0
        Preferences.lastLoginTime = Date(timeIntervalSinceNow: -120)

        // Setup expectations
        navigationMock.pushExpectation = expectation(description: "Push Main Flow")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")
        authServiceMock.authenticationExpectation = expectation(description: "Authentication")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .success(true)

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPushedViewController
        ).to(beAKindOf(UITabBarController.self))
    }

    func test_withAuthServiceNotAvailable_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true
        Preferences.authMinutesTimeout = 0
        Preferences.lastLoginTime = Date(timeIntervalSinceNow: -120)

        // Setup expectations
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = false

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationUnavailable_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true
        Preferences.authMinutesTimeout = 0
        Preferences.lastLoginTime = Date(timeIntervalSinceNow: -120)

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.unavailable)

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationCanceled_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true
        Preferences.authMinutesTimeout = 0
        Preferences.lastLoginTime = Date(timeIntervalSinceNow: -120)

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.canceled)

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationFailure_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true
        Preferences.authMinutesTimeout = 0
        Preferences.lastLoginTime = Date(timeIntervalSinceNow: -120)

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.unauthorized)

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_onAuthenticationPartialFailure_shouldShowError() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true
        Preferences.authMinutesTimeout = 0
        Preferences.lastLoginTime = Date(timeIntervalSinceNow: -120)

        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .success(false)

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_resume_withLoginTimeout_shouldStopCoordinator() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true
        Preferences.authMinutesTimeout = 0
        Preferences.lastLoginTime = Date(timeIntervalSinceNow: -120)

        // Setup child

        let coordinatorSpy = CoordinatorSpy()
        coordinator.start(child: coordinatorSpy)
        expect(coordinatorSpy.didStart).to(beTrue())

        // Setup expectations
        navigationMock.pushExpectation = expectation(description: "Push Main Flow")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .success(true)

        // Resume coordinator
        coordinator.resume()

        // Check stopped coordinator
        expect(coordinatorSpy.didStop).to(beTrue())

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPushedViewController
        ).to(beAKindOf(UITabBarController.self))
    }

    func test_welcomeCoordinatorDidStop_shouldStartLoginFlow() {
        let welcomeCoordinator = WelcomeCoordinator()
        coordinator.coordinatorDidStop(welcomeCoordinator)

        expect(
            self.coordinator.children
        ).to(containElementSatisfying {$0 is LoginCoordinator})
    }

    func test_authErrorCoordinatorDidStop_shouldStartLoginFlow() {
        let authErrorCoordinator = AuthErrorCoordinator(error: .canceled)
        coordinator.coordinatorDidStop(authErrorCoordinator)

        expect(
            self.coordinator.children
        ).to(containElementSatisfying {$0 is LoginCoordinator})
    }

    func test_otherCoordinatorDidStop_shouldNotStartLoginFlow() {
        let otherCoordinator = BaseCoordinator()
        coordinator.coordinatorDidStop(otherCoordinator)

        expect(
            self.coordinator.children
        ).notTo(containElementSatisfying {$0 is LoginCoordinator})
    }
}
