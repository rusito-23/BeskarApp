//
//  LoadingViewController.swift
//  BeskarTests
//
//  Created by Igor on 07/02/2021.
//

import BeskarUI

final class LoadingViewController: ViewController<LoadingView> {

    // MARK: Private properties

    private var titleText: String

    // MARK: Initializers

    init(titleText: String = "LOADING".localized) {
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
}
