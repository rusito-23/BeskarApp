//
//  TabBarController.swift
//  BeskarUI
//
//  Created by Igor on 09/02/2021.
//

import UIKit

/// A Tab Controller that conforms to the Beskar Style.
open class TabBarController: UITabBarController {

    // MARK: Properties

    public weak var coordinator: Coordinator?

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
