//
//  WalletDetailCoordinator.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import UIKit

final class WalletDetailCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { walletDetailViewController }

    // MARK: Private Properties

    private lazy var walletDetailViewController: WalletDetailViewController = {
        let presented = WalletDetailViewController()
        presented.modalPresentationStyle = .formSheet
        return presented
    }()
}
