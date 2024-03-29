//
//  ViewControllerExtensions.swift
//  Beskar
//
//  Created by Igor on 11/02/2021.
//
// Beskar UI View Controller Extensions

import BeskarUI
import BeskarKit

// MARK: - Loading

extension ViewController {
    /// Adds a view that shows a loading indicator on top
    func startLoading(_ title: String = "LOADING".localized) {
        // prevent view from loading twice
        guard !view.subviews.contains(
            where: {$0 is LoadingView}
        ) else { return }

        // Create loading view
        let loadingView: LoadingView = {
            let view = LoadingView()
            view.spinner.startAnimating()
            view.titleLabel.text = title
            return view
        }()

        // Add to view and start animating
        view.addSubview(loadingView)
        loadingView.edges(to: view)
        view.bringSubviewToFront(loadingView)
    }

    /// Removes the loading view, if exists
    func stopLoading() {
        for view in view.subviews where view is LoadingView {
            view.removeFromSuperview()
        }
    }
}

// MARK: - Errors

extension ViewController {

    /// Shows an error with the given message
    func showError(
        _ message: String,
        buttonTitle: String,
        completion: @escaping (() -> Void)
    ) {
        let errorViewController = ErrorViewController(
            subtitle: message,
            buttonTitle: buttonTitle,
            onButtonTappedCompletion: completion
        )

        present(errorViewController, animated: true)
    }
}

// MARK: - Input Field Binding

extension ViewController {

    /// Helps binding a Form Input View with a given Field View Model
    func bind(
        _ inputField: InputField,
        with viewModel: InputFieldViewModelProtocol?
    ) {
        guard let viewModel = viewModel else { return }

        inputField.textPublisher.sink(
            receiveValue: viewModel.validate
        ).store(in: &subscriptions)

        viewModel.messagesPublisher.assign(
            to: \.messages, on: inputField
        ).store(in: &subscriptions)
    }

    /// Helps binding a Form Picker Input View with a given Picker Field View Model
    func bindPicker(
        _ inputField: PickerInputField<Currency>,
        with viewModel: CurrencyInputFieldViewModelProtocol?
    ) {
        guard let viewModel = viewModel else { return }

        inputField.$selected.sink(
            receiveValue: viewModel.validate
        ).store(in: &subscriptions)

        viewModel.messagesPublisher.assign(
            to: \.messages, on: inputField
        ).store(in: &subscriptions)
    }
}
