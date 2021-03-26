//
//  BaseCoordinatorTests.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import Nimble
import XCTest
@testable import Beskar

final class BaseCoordinatorTests: XCTestCase {

    // MARK: Properties

    private var coordinator: BaseCoordinator!
    private var navigationControllerMock: NavigationControllerMock!

    // MARK: Setup

    override func setUp() {
        coordinator = BaseCoordinator()
        navigationControllerMock = NavigationControllerMock()
    }

    // MARK: Tests

    func test_startAndStop_childWithPresentation_shouldUpdateTheReferenceInTheChildren() {
        let child = ChildCoordinator()
        child.presenter = .presentation(navigationControllerMock)

        // Start should add the child to reference array
        coordinator.start(child: child)
        expect(
            self.coordinator.children
        ).to(containElementSatisfying { $0 is ChildCoordinator })
        expect(
            self.navigationControllerMock.lastPresentedViewController
        ).to(beAKindOf(ChildCoordinator.ChildViewController.self))

        // Stop should remove the child from the array
        child.stop()
        expect(
            self.coordinator.children
        ).notTo(containElementSatisfying { $0 is ChildCoordinator })
    }

    func test_startAndStop_childWithNavigation_shouldUpdateTheReferenceInTheChildren() {
        let child = ChildCoordinator()
        child.presenter = .navigation(navigationControllerMock)

        // Start should add the child to reference array
        coordinator.start(child: child)
        expect(
            self.coordinator.children
        ).to(containElementSatisfying { $0 is ChildCoordinator })
        expect(
            self.navigationControllerMock.lastPushedViewController
        ).to(beAKindOf(ChildCoordinator.ChildViewController.self))

        // Stop should remove the child from the array
        child.stop()
        expect(
            self.coordinator.children
        ).notTo(containElementSatisfying { $0 is ChildCoordinator })
    }

    func test_defaultPresented_shouldBeNil() {
        expect(self.coordinator.presented).to(beNil())
    }
}

// MARK: - Test Helpers

extension BaseCoordinatorTests {

    /// A child coordinator class to verify some things
    final class ChildCoordinator: BaseCoordinator {
        override var presented: UIViewController? { ChildViewController() }

        /// An empty view controller to mock presentation
        final class ChildViewController: UIViewController {}
    }
}
