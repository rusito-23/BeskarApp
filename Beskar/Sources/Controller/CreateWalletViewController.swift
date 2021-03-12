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
        // form field validations
        customView.nameField.textPublisher.sink(
            receiveValue: viewModel.validate(name:)
        ).store(in: &subscriptions)

        customView.descriptionField.textPublisher.sink(
            receiveValue: viewModel.validate(description:)
        ).store(in: &subscriptions)

        // form errors
        viewModel.$nameMessages.assign(
            to: \.messages, on: customView.nameField
        ).store(in: &subscriptions)

        viewModel.$descriptionMessages.assign(
            to: \.messages, on: customView.descriptionField
        ).store(in: &subscriptions)
    }
}
