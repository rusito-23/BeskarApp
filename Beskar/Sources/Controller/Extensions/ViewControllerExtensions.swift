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
        let loadingView: LoadingView = {
            let view = LoadingView()
            view.spinner.startAnimating()
            view.titleLabel.text = title
            return view
        }()

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
