//
//  ActionButton.swift
//  BeskarUI
//
//  Created by Igor on 14/02/2021.
//

import UIKit

/// A Round button without a title
/// # Discussion #
/// Requires a system icon that reflects exactly the kind of action that the button triggers.
/// Users the SF System Icons and uses them with a large point size, all configured from
/// within this view. Uses `tertiary` tinto color for normal state and `secondary` for highlighted.
public class ActionButton: UIButton {

    // MARK: Types

    public enum Kind {
        case primary
        case secondary
        case tertiary
    }

    // MARK: Computer Properties

    private lazy var symbolConfiguration = UIImage.SymbolConfiguration(
        pointSize: UIFont.Beskar.Size.typeMedium.rawValue
    )

    // MARK: Initializers

    public init(
        imageName: UIImage.Beskar.Name.System,
        identifier: String? = nil,
        label: String? = nil
    ) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        accessibilityIdentifier = identifier
        accessibilityLabel = label

        setUpImage(with: imageName)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpImage(with imageName: UIImage.Beskar.Name.System) {
        setImage(
            UIImage.beskar
                .create(imageName)?
                .withTintColor(
                    UIColor.beskar.tertiary,
                    renderingMode: .alwaysOriginal
            ), for: .normal
        )

        setImage(
            UIImage.beskar
                .create(imageName)?
                .withTintColor(
                    UIColor.beskar.secondary,
                    renderingMode: .alwaysOriginal
            ), for: .highlighted
        )

        setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .highlighted)
        imageView?.contentMode = .scaleAspectFit
    }
}
