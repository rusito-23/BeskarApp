//
//  WelcomeViewController.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

import BeskarUI
import UIKit

final class WelcomeViewController: ViewController<WelcomeView> {

    // MARK: Properties

    var onAllowButtonCompletion: (() -> Void)?

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActions()
    }

    // MARK: Private

    private func setUpActions() {
        customView.allowButton.addTarget(
            self,
            action: #selector(onAllowButtonTapped),
            for: .touchUpInside
        )
    }

    // MARK: Actions

    @objc private func onAllowButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            self?.onAllowButtonCompletion?()
        }
    }
}
