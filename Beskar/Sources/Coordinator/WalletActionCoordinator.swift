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

    override var presented: UIViewController? { walletActionViewController }

    // MARK: Private Properties

    private var viewModel: WalletActionViewModel

    private lazy var walletActionViewController: UIViewController = {
        let viewController = WalletActionViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .formSheet
        viewController.coordinator = self
        return viewController
    }()

    // MARK: Initializer

    init(wallet: Wallet, kind: Transaction.Kind) {
        viewModel = WalletActionViewModel(wallet: wallet, kind: kind)
    }
}
