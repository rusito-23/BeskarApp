//
//  TransactionDetailCoordinator.swift
//  Beskar
//
//  Created by Rusito on 25/05/2024.
//

import BeskarUI
import BeskarKit
import UIKit

// MARK: - Flow Protocol

protocol TransactionDetailCoordinatorFlow: AnyObject {}

// MARK: - Coordinator

final class TransactionDetailCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { viewController }

    // MARK: Private Properties

    private let transaction: Transaction

    private lazy var viewController = TransactionDetailViewController(
        viewModel: transactionViewModel
    )

    private lazy var transactionViewModel: TransactionViewModel = {
        let viewModel = TransactionViewModel()
        viewModel.transaction = transaction
        return viewModel
    }()

    // MARK: Initializer

    init(transaction: Transaction) {
        self.transaction = transaction
    }
}
