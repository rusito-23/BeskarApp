//
//  RegisterViewController.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import BeskarUI
import Combine
import UIKit

final class RegisterViewController: BeskarViewController {

    // MARK: - Properties

    private lazy var contentView = RegisterView()
    private var viewModel: RegisterViewModel
    private var bindings = Set<AnyCancellable>()

    // MARK: - Initializers

    init(viewModel: RegisterViewModel = RegisterViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - View Lifecycle

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }

    // MARK: - Private Methods

    private func setUpBindings() {
        contentView.titleLabel.text = viewModel.title
        contentView.subtitleLabel.text = viewModel.subtitle
        contentView.passwordField.placeholder = viewModel.passwordPlaceholder
        contentView.repeatPasswordField.placeholder = viewModel.repeatPlaceholder
        contentView.registerButton.setTitle(viewModel.buttonTitle, for: .normal)

        contentView.passwordField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &bindings)
    }
}
