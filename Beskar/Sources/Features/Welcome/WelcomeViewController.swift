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

    weak var coordinator: Coordinator?

    // MARK: Initializer

    init(coordinator: Coordinator? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }

    // MARK: View Controller Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActions()
    }

    // MARK: Private

    private func setUpActions() {
        ui.allowButton.addTarget(
            self,
            action: #selector(onAllowButtonTapped),
            for: .touchUpInside
        )
    }

    // MARK: Actions

    @objc private func onAllowButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            self?.coordinator?.stop()
        }
    }
}
