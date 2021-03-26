//
//  WalletListCoordinatorTests.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import Nimble
import XCTest
@testable import Beskar

final class WalletListCoordinatorTests: XCTestCase {

    // MARK: Properties

    private var coordinator: WalletListCoordinator!
    private var navigationControllerMock: NavigationControllerMock!

    // MARK: Setup

    override func setUp() {
        coordinator = WalletListCoordinator()
        navigationControllerMock = NavigationControllerMock()
        coordinator.presenter = .presentation(navigationControllerMock)
    }

    // MARK: Tests

    func test_startNewWalletFlow_shouldStartCreateWalletCoordinator() {
        coordinator.startNewWalletFlow()

        expect(self.coordinator.children)
            .to(containElementSatisfying { $0 is CreateWalletCoordinator})
    }

    func test_startWalletDetailFlow_shouldStartWalletDetailCoordinator() {
        coordinator.startWalletDetailFlow(for: Mock.Wallets.withPesos)

        expect(self.coordinator.children)
            .to(containElementSatisfying { $0 is WalletDetailCoordinator})
    }

    func test_startWalletActionFlow_shouldStartWalletActionCoordinator() {
        coordinator.startWalletActionFlow(for: Mock.Wallets.withPesos, kind: .deposit)

        expect(self.coordinator.children)
            .to(containElementSatisfying { $0 is WalletActionCoordinator})
    }

}
