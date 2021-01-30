//
//  WelcomeView.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import BeskarUI
import UIKit

final class WelcomeView: UIView {

    // MARK: - Subviews

    private lazy var titleLabel = BeskarLabel(
        size: .large,
        color: UIColor.beskar.primary
    )

    private lazy var subtitleLabel = BeskarLabel(
        size: .typeMedium,
        color: UIColor.beskar.secondary
    )

    private lazy var passwordField: UITextField = {
        let field = BeskarPasswordField()
        field.placeholder = "Password"
        return field
    }()

    private lazy var repeatPasswordField: UITextField = {
        let field = BeskarPasswordField()
        field.placeholder = "Repeat password"
        return field
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        titleLabel.text = "WELCOME TO BESKAR"
        subtitleLabel.text = "Please enter a password to get started"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setUpViews() {
        addSubviews(
            titleLabel,
            subtitleLabel,
            passwordField,
            repeatPasswordField
        )

        // Title Label Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: layoutMarginsGuide.topAnchor,
                constant: Spacing.large.rawValue
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])

        // Subtitle Label Constraints
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Spacing.medium.rawValue
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])

        // Password Field Constraints
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: Spacing.medium.rawValue
            ),
            passwordField.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            passwordField.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])

        // Repeat Password Field Constraints
        NSLayoutConstraint.activate([
            repeatPasswordField.topAnchor.constraint(
                equalTo: passwordField.bottomAnchor,
                constant: Spacing.medium.rawValue
            ),
            repeatPasswordField.leadingAnchor.constraint(
                equalTo: layoutMarginsGuide.leadingAnchor,
                constant: Spacing.small.rawValue
            ),
            repeatPasswordField.trailingAnchor.constraint(
                equalTo: layoutMarginsGuide.trailingAnchor,
                constant: -Spacing.small.rawValue
            ),
        ])
    }
}
