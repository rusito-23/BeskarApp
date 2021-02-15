//
//  ViewControllerExtensions.swift
//  Beskar
//
//  Created by Igor on 11/02/2021.
//
// Beskar UI View Controller Extensions

import BeskarUI

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
