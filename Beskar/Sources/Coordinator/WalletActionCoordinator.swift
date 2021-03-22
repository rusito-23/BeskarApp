//
//  WalletActionCoordinator.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import BeskarKit
import UIKit
import TinyConstraints

final class WalletActionCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController?

    lazy var viewModel = WalletActionViewModel(
        wallet: wallet,
        kind: kind
    )

    lazy var presented: UIViewController? = ModalViewController(
        viewController: viewController
    )

    lazy var viewController: UIViewController = {
        let viewController = WalletActionViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .formSheet
        viewController.coordinator = self
        return viewController
    }()

    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?

    // MARK: Private properties

    private let wallet: Wallet
    private let kind: Transaction.Kind

    // MARK: Initializer

    init(wallet: Wallet, kind: Transaction.Kind) {
        self.wallet = wallet
        self.kind = kind
    }
}
