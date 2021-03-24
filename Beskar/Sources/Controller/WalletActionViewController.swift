//
//  WalletActionViewController.swift
//  Beskar
//
//  Created by Igor on 13/03/2021.
//

import BeskarUI
import BeskarKit
import UIKit

final class WalletActionViewController: ViewController<WalletActionView> {

    // MARK: Properties

    weak var coordinator: Coordinator?

    // MARK: Private Properties

    private let viewModel: WalletActionViewModel

    // MARK: Initializer

    init(viewModel: WalletActionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: ViewController Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpBindings()
        setUpActions()
    }

    // MARK: Private Methods

    private func setUpView() {
        ui.amountField.currencySymbol = viewModel.currencySymbol
        ui.amountField.amount = viewModel.amount
        ui.titleLabel.text = viewModel.titleText
        ui.subtitleLabel.text = viewModel.actionText
        ui.disclaimerLabel.text = viewModel.disclaimerText
        ui.saveButton.setTitle(viewModel.buttonTitle, for: .normal)
    }

    private func setUpBindings() {
        // Save button bindings
        viewModel.$shouldEnableSaveButton.assign(
            to: \.isEnabled, on: ui.saveButton
        ).store(in: &subscriptions)

        // Field bindings
        bind(ui.summaryField, with: viewModel.summaryFieldViewModel)
        ui.summaryField.textPublisher.assign(
            to: \.summary, on: viewModel
        ).store(in: &subscriptions)

        ui.amountField.textPublisher.sink { _ in
            guard let amount = self.ui.amountField.amount else { return }
            self.viewModel.amount = amount
            self.viewModel.updateSaveButtonAvailability()
        }.store(in: &subscriptions)
    }

    private func setUpActions() {
        ui.saveButton.addTarget(
            self,
            action: #selector(onSaveButtonTapped),
            for: .touchUpInside
        )
    }

    // MARK: Private Actions

    @objc private func onSaveButtonTapped(_ sender: UIButton) {
        startLoading()
        viewModel.start { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case let .success(didSucceed) where didSucceed:
                self.coordinator?.stop()
            case .failure, .success:
                self.showError(
                    "TRANSACTION_SAVE_ERROR".localized,
                    buttonTitle: "OK".localized,
                    completion: {[weak self] in self?.coordinator?.stop() }
                )
            }
        }
    }
}
