//
//  TransactionDetailViewController.swift
//  Beskar
//
//  Created by Rusito on 25/05/2024.
//

import BeskarUI
import BeskarKit
import UIKit

final class TransactionDetailViewController: ViewController<TransactionDetailView> {

    // MARK: Properties

    private let viewModel: TransactionViewModel

    // MARK: Initializer

    init(viewModel: TransactionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: View Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        viewModel.summaryPublisher.assign(
            to: \.text, on: ui.summaryLabel
        ).store(in: &subscriptions)

        viewModel.datePublisher.assign(
            to: \.text, on: ui.dateLabel
        ).store(in: &subscriptions)

        viewModel.compactAmountPublisher.assign(
            to: \.text, on: ui.amountLabel
        ).store(in: &subscriptions)

        viewModel.kindPublisher.sink { kind in
            switch kind {
            case .deposit:
                self.ui.kindIconView.image = UIImage.beskar.create(.deposit)
                self.ui.kindIconView.tintColor = UIColor.beskar.positive
            case .withdraw:
                self.ui.kindIconView.image = UIImage.beskar.create(.withdraw)
                self.ui.kindIconView.tintColor = UIColor.beskar.negative
            default:
                self.ui.kindIconView.image = nil
                self.ui.kindIconView.tintColor = nil
            }
        }.store(in: &subscriptions)
    }
}
