//
//  CreateWalletViewController.swift
//  Beskar
//
//  Created by Igor on 17/02/2021.
//

import BeskarUI
import Combine
import UIKit

final class CreateWalletViewController: ViewController<CreateWalletView> {

    // MARK: Properties

    weak var coordinator: CreateWalletCoordinator?

    // MARK: Private Properties

    private lazy var viewModel: CreateWalletViewModel = .resolved

    // MARK: View Controller Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        setUpActions()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        // field bindings
        bind(ui.nameField, with: viewModel.nameFieldViewModel)
        bind(ui.descriptionField, with: viewModel.descriptionFieldViewModel)
        bindPicker(ui.currencyField, with: viewModel.currencyFieldViewModel)

        // currencies
        viewModel.$currencies.assign(
            to: \.options,
            on: ui.currencyField
        ).store(in: &subscriptions)

        // bind button with validations
        viewModel.$shouldEnableCreateButton.assign(
            to: \.isEnabled,
            on: ui.createButton
        ).store(in: &subscriptions)

        // bind model properties
        [
            ui.nameField.textPublisher.assign(to: \.name, on: viewModel),
            ui.descriptionField.textPublisher.assign(to: \.description, on: viewModel),
            ui.currencyField.$selected.assign(to: \.currency, on: viewModel),
        ].forEach { $0.store(in: &subscriptions) }
    }

    private func setUpActions() {
        ui.closeButton.addTarget(
            self,
            action: #selector(onCloseButtonTapped),
            for: .touchUpInside
        )

        ui.createButton.addTarget(
            self,
            action: #selector(onCreateButtonTapped),
            for: .touchUpInside
        )
    }

    // MARK: Actions

    @objc func onCloseButtonTapped(_ sender: UIBarButtonItem?) {
        self.coordinator?.stop()
    }

    @objc func onCreateButtonTapped(_ sender: UIBarButtonItem) {
        startLoading()
        viewModel.start { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            switch result {
            case let .success(didSucceed) where didSucceed:
                self.coordinator?.stop()
            case .failure, .success:
                self.showError(
                    "WALLET_CREATION_ERROR".localized,
                    buttonTitle: "CANCEL".localized,
                    completion: {[weak self] in self?.coordinator?.stop() }
                )
            }
        }
    }
}
