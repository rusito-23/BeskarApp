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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        viewModel.walletName
            .assign(to: \.text, on: ui.walletValue)
            .store(in: &subscriptions)

        viewModel.summaryPublisher
            .assign(to: \.text, on: ui.summaryValue)
            .store(in: &subscriptions)

        viewModel.datePublisher
            .assign(to: \.text, on: ui.dateValue)
            .store(in: &subscriptions)

        viewModel.amountPublisher
            .assign(to: \.text, on: ui.amountValue)
            .store(in: &subscriptions)

        viewModel.kindPublisher.sink { kind in
            self.ui.kindIconView.image = kind?.image
            self.ui.kindIconView.tintColor = kind?.tintColor
            self.ui.kindValue.text = kind?.noun
        }.store(in: &subscriptions)
    }
}
