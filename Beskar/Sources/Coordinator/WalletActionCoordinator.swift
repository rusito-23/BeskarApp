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

final class WalletActionCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { modalViewController }

    // MARK: Private Properties

    private lazy var viewModel = WalletActionViewModel(
        wallet: wallet,
        kind: kind
    )

    private lazy var walletActionViewController: UIViewController = {
        let viewController = WalletActionViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .formSheet
        viewController.coordinator = self
        return viewController
    }()

    private lazy var modalViewController = ModalViewController(
        viewController: walletActionViewController
    )

    private let wallet: Wallet
    private let kind: Transaction.Kind

    // MARK: Initializer

    init(wallet: Wallet, kind: Transaction.Kind) {
        self.wallet = wallet
        self.kind = kind
    }
}
