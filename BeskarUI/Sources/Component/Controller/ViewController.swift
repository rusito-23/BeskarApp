//
//  ViewController.swift
//  BeskarUI
//
//  Created by Igor on 29/01/2021.
//
//  Design System View Controller

import UIKit

/// Beskar Design System Controllers
/// Override default functions for `UIViewController`
/// to use Beskar colors and presentation styles by default.

// MARK: - View Controller

open class ViewController: UIViewController {

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

// MARK: - Tab Bar Controller

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
