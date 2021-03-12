//
//  CreateWalletViewController.swift
//  Beskar
//
//  Created by Igor on 17/02/2021.
//

import BeskarUI
import Combine

final class CreateWalletViewController: ViewController<CreateWalletView> {

    // MARK: Private Properties

    private lazy var viewModel: CreateWalletViewModel = .resolved

    // MARK: View Controller Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }

    // MARK: Private Methods

    private func setUpBindings() {
        // field bindings
        bind(customView.nameField, with: viewModel.nameFieldViewModel)
        bind(customView.descriptionField, with: viewModel.descriptionFieldViewModel)
        bindPicker(customView.currencyField, with: viewModel.currencyFieldViewModel)

        // currencies
        viewModel.$currencies.assign(
            to: \.options,
            on: customView.currencyField
        ).store(in: &subscriptions)

        // bind button with validations
        viewModel.$isValid.assign(
            to: \.isEnabled,
            on: customView.createButton
        ).store(in: &subscriptions)
    }
}
