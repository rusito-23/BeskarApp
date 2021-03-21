//
//  WalletActionCoordinator.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import UIKit
import TinyConstraints

final class WalletActionCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController?

    lazy var presented: UIViewController? = ModalViewController(
        viewController: viewController
    )

    lazy var viewController: UIViewController = {
        let presented = WalletActionViewController()
        presented.modalPresentationStyle = .formSheet
        return presented
    }()

    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?
}
