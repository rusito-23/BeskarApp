//
//  UITableViewExtensionsTests.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import Nimble
import XCTest
@testable import Beskar

final class UITableViewExtensionsTests: XCTestCase {

    // MARK: Properties

    private var tableViewSpy: UITableViewSpy!

    // MARK: Setup

    override func setUp() {
        tableViewSpy = UITableViewSpy()
    }

    // MARK: Tests

    func test_convenienceDequeue_shouldCallDequeueReusableCell() {
        _ = tableViewSpy.dequeue(UITableViewCell.self)
        expect(self.tableViewSpy.didDequeueReusableCell).to(beTrue())
    }
}

// MARK: Test Helpers

extension UITableViewExtensionsTests {
    final class UITableViewSpy: UITableView {

        // MARK: Properties

        var didDequeueReusableCell: Bool = false

        // MARK: Overrides

        override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
            didDequeueReusableCell = true
            return super.dequeueReusableCell(withIdentifier: identifier)
        }
    }
}
