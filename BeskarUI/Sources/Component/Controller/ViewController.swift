//
//  ViewController.swift
//  BeskarUI
//
//  Created by Igor on 29/01/2021.
//
//  Design System View Controller

import UIKit

// MARK: - View Controller

/// Add view controller functionality to enable the auto-setup of a custom view.
/// Overrides the `viewDidLoad` method to load the view and creates an `open lazy var`
/// that contains the reference to the view (with the given type).
/// Also sets default background color and presentation style to ensure design system conformance.
///
/// Example usage:
/// ```
/// class MyViewController: ViewController<MyView> {
///     override func viewDidLoad() {
///         super.viewDidLoad()
///
///         // customView is of kind MyView
///         customView.myButton.addTarget(self, ...)
///     }
/// }
/// ```

open class ViewController<View>: UIViewController where View: UIView {

    // MARK: Properties

    open lazy var customView = View()

    // MARK: View Lifecycle

    open override func loadView() {
        view = customView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beskar.base
    }

    // MARK: Initializer

    public override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .fullScreen
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Tab Bar Controller

/// Set default background color and presentation style to
/// `UITabBarController` to ensure Design System conformance.

open class TabBarController: UITabBarController {

    // MARK: View Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beskar.base
    }

    // MARK: Initializer

    public override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .fullScreen
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
