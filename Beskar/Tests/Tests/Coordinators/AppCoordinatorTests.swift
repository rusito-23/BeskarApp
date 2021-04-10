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
        setUpSwinject()
        coordinator = AppCoordinator(presenter: navigationMock)
        setUpPreferences()
    }

    private func setUpSwinject() {
        injector.register(AuthServiceProtocol.self) { _ in self.authServiceMock }
    }

    private func setUpPreferences() {
        Preferences.isNotFirstLaunch = true
        Preferences.sessionTimeoutInMinutes = 0
        Preferences.sessionPauseDate = Date(timeIntervalSinceNow: -120)
    }

    // MARK: Tests

    func test_start_shouldMakeWindowKeyAndVisible() {
        coordinator.start()

        expect(
            self.coordinator.window.isKeyWindow
        ).to(beTrue())

        expect(
            self.coordinator.window.isHidden
        ).to(beFalse())
    }

    func test_resume_onFirstLaunch_shouldStartWelcomeFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = false

        // Resume coordinator
        coordinator.resume()

        // Check last presented
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(WelcomeViewController.self))
    }

    func test_resume_afterFirstLaunch_shouldStartLoginFlow() {
        // Setup first launch
        Preferences.isNotFirstLaunch = true

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

    func test_startLoginFlow_withAuthServiceUnavailable_shouldShowError() {
        // Setup expectations
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = false

        // Start Login Flow
        coordinator.startLoginFlow()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_startLoginFlow_withAuthServiceUnavailableResponse_shouldShowError() {
        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.unavailable)

        // Start Login Flow
        coordinator.startLoginFlow()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_startLoginFlow_withAuthCanceled_shouldShowError() {
        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.canceled)

        // Start Login Flow
        coordinator.startLoginFlow()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_startLoginFlow_withAuthFailure_shouldShowError() {
        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .failure(.unauthorized)

        // Start Login Flow
        coordinator.startLoginFlow()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_startLoginFlow_wuthAuthenticationPartialFailure_shouldShowError() {
        // Setup expectations
        navigationMock.presentExpectation = expectation(description: "Present Error")
        authServiceMock.availabilityExpectation = expectation(description: "Auth Availability")

        // Setup mock responses
        authServiceMock.isAvailableMock = true
        authServiceMock.authenticationSuccessMock = .success(false)

        // Start Login Flow
        coordinator.startLoginFlow()

        // Check last presented
        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_resume_withLoginTimeout_shouldStopAllCoordinators() {
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

    func test_pause_withBlockScreenPreferenceOn_shouldShowBlockScreen() {
        Preferences.blockScreenOnBackground = true
        navigationMock.presentExpectation = expectation(description: "Present Block Screen")
        coordinator.start()
        coordinator.pause()

        waitForExpectations(timeout: 3.0)
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beAKindOf(BlockScreenViewController.self))
    }

    func test_pause_withBlockScreenPreferenceOff_shouldNotShowBlockScreen() {
        Preferences.blockScreenOnBackground = false
        coordinator.start()
        coordinator.pause()
        expect(
            self.navigationMock.lastPresentedViewController
        ).to(beNil())
    }

    func test_stop_shouldSetForceLogin() {
        Preferences.shouldForceLogin = false
        coordinator.start()
        coordinator.stop()
        expect(Preferences.shouldForceLogin).to(beTrue())
    }
}
