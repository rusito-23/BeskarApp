//
//  ErrorView.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

import BeskarUI
import UIKit

final class ErrorView: UIView {

    // MARK: Subviews

    lazy var titleLabel = Label(
        size: .large,
        weight: .traitBold,
        identifier: A.ErrorScreen.title
    )

    lazy var subtitleLabel = Label(
        size: .small,
        identifier: A.ErrorScreen.subtitle
    )

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "xmark.octagon")
        view.contentMode = .scaleAspectFit
        view.accessibilityIdentifier = A.ErrorScreen.image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpViews() {
        addSubviews(
            titleLabel,
            imageView,
            subtitleLabel
        )

        // Title Constraints
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

        // Error Image Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Spacing.large.rawValue
            ),
            imageView.heightAnchor.constraint(
                equalToConstant: Size.large.rawValue
            ),
            imageView.widthAnchor.constraint(
                equalToConstant: Size.large.rawValue
            ),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        // Subtitle Constraints
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: Spacing.large.rawValue
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
    }
}
