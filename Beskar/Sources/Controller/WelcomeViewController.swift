//
//  WelcomeViewController.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import BeskarUI
import UIKit

final class WelcomeViewController: BeskarViewController {

    // MARK: - Subviews

    private lazy var welcomeView = WelcomeView()

    // MARK: - View Lifecycle

    override func loadView() {
        view = welcomeView
    }

}
