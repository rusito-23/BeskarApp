//
//  WalletDetailCoordinator.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import BeskarKit
import UIKit

final class WalletDetailCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { walletDetailViewController }

    // MARK: Private Properties

    private let wallet: Wallet

    private lazy var walletDetailViewController = WalletDetailViewController(
        viewModel: walletViewModel
    )

    private lazy var walletViewModel: WalletViewModel = {
        let viewModel = WalletViewModel()
        viewModel.wallet = wallet
        return viewModel
    }()

    // MARK: Initializer

    init(wallet: Wallet) {
        self.wallet = wallet
    }
}
