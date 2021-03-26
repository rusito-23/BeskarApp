//
//  ViewControllerExtensions.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import Nimble
import XCTest
@testable import Beskar

final class ViewControllerExtensionsTests: XCTestCase {

    // MARK: Properties

    private var viewControllerSpy: ViewControllerSpy!

    // MARK: Setup

    override func setUp() {
        viewControllerSpy = ViewControllerSpy()
    }

    // MARK: Tests

    func test_showError_shouldPresentAnErrorViewController() {
        viewControllerSpy.showError(
            "Some Message",
            buttonTitle: "Some Title",
            completion: {}
        )

        expect(
            self.viewControllerSpy.lastPresentedViewController
        ).to(beAKindOf(ErrorViewController.self))
    }

    func test_startLoading_shouldShowLoadingView() {
        viewControllerSpy.startLoading()

        expect(
            self.viewControllerSpy.view.subviews[0]
        ).to(beAKindOf(LoadingView.self))
    }

    func test_startLoading_whenCalledTwice_shouldNotShowLoadingViewAgain() {
        viewControllerSpy.startLoading()
        expect(
            self.viewControllerSpy.view.subviews
        )
        .to(haveCount(1))
        .to(containElementSatisfying { $0 is LoadingView })

        viewControllerSpy.startLoading()
        expect(
            self.viewControllerSpy.view.subviews
        )
        .to(haveCount(1))
        .to(containElementSatisfying { $0 is LoadingView })
    }
}
