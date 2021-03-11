//
//  NavigationController.swift
//  BeskarUI
//
//  Created by Igor on 09/02/2021.
//

import UIKit

/// # Description #
/// A Navigation Controller that conforms to the Beskar Style.
/// Provides overrides that set up the default Beskar style.
///
/// - Tag: NavigationController
open class NavigationController: UINavigationController {

    // MARK: View Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beskar.base
    }

    // MARK: Initializers

    public override init(
        navigationBarClass: AnyClass?,
        toolbarClass: AnyClass?
    ) {
        super.init(
            navigationBarClass: navigationBarClass,
            toolbarClass: toolbarClass
        )
        setUp()
    }

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setUp()
    }

    override public init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUp() {
        isNavigationBarHidden = true
        modalPresentationStyle = .fullScreen
    }
}
