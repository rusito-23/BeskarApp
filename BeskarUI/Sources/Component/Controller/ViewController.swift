//
//  ViewController.swift
//  BeskarUI
//
//  Created by Igor on 29/01/2021.
//
//  Design System View Controller

import Combine
import UIKit

/// # Description #
/// A View Controller that conforms to the Beskar Style.
/// Provides overrides that set up the style and helpers to auto-setup a custom view, saved in `ui`.
/// Also, provides a default `subscriptions` set to store bindings.
///
/// # Example #
/// ```
/// class MyViewController: ViewController<MyView> {
///     override func viewDidLoad() {
///         super.viewDidLoad() // this is important
///
///         // ui is of kind MyView
///         ui.myButton.addTarget(self, ...)
///     }
/// }
/// ```
///
/// # Note #
/// See also [Navigation Controller](x-source-tag:NavigationController)
///
/// - Tag: ViewController
open class ViewController<ViewType>: UIViewController where ViewType: UIView {

    // MARK: Properties

    /// The view wrapped in the given associated type
    public lazy var ui = ViewType()

    /// A subscription set to store Combine bindings
    public lazy var subscriptions = Set<AnyCancellable>()

    // MARK: View Lifecycle

    open override func loadView() {
        view = ui
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
