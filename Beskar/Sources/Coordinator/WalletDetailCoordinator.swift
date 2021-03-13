//
//  WalletDetailCoordinator.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import UIKit

final class WalletDetailCoordinator: Coordinator {

    // MARK: Coordinator Properties

    var presenter: UIViewController?

    lazy var presented: UIViewController? = {
        let presented = WalletDetailViewController()
        presented.modalPresentationStyle = .formSheet
        return presented
    }()

    lazy var children: [Coordinator] = []
    var onStop: (() -> Void)?
    var onStart: (() -> Void)?
    weak var delegate: CoordinatorDelegate?
}
