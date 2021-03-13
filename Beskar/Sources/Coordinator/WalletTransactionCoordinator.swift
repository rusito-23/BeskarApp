//
//  WalletTransactionCoordinator.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import UIKit

final class WalletTransactionCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController?

    lazy var presented: UIViewController? = {
        let presented = WalletTransactionViewController()
        presented.modalPresentationStyle = .formSheet
        return presented
    }()

    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?
}
