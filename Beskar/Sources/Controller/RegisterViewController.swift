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
        viewModel.setUpData(on: contentView)

        contentView.passwordField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &bindings)

        contentView.repeatPasswordField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.repeatPassword, on: viewModel)
            .store(in: &bindings)

        viewModel.passwordValidation
            .receive(on: DispatchQueue.main)
            .assign(to: \.validationResult, on: contentView)
            .store(in: &bindings)
    }
}
