//
//  CurrencyExtensionsTests.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import BeskarKit
import Nimble
import XCTest
@testable import Beskar

final class CurrencyExtensionsTests: XCTestCase {

    // MARK: Tests

    func test_display_withDollars_shouldBeDisplayName() {
        let currency: Currency = .dollars
        expect(currency.displayName).to(equal(currency.display))
    }

    func test_display_withPesos_shouldBeDisplayName() {
        let currency: Currency = .pesos
        expect(currency.displayName).to(equal(currency.display))
    }

    func test_display_withEuros_shouldBeDisplayName() {
        let currency: Currency = .euros
        expect(currency.displayName).to(equal(currency.display))
    }
}
