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

    // MARK: Initializers

    public init(
        imageName: UIImage.Beskar.Name.System,
        size: UIFont.Beskar.Size = .typeMedium,
        color: UIColor = UIColor.beskar.tertiary,
        highlightColor: UIColor = UIColor.beskar.secondary,
        identifier: String? = nil,
        label: String? = nil
    ) {
        super.init(frame: .zero)
        accessibilityIdentifier = identifier
        accessibilityLabel = label

        setUpImage(
            with: imageName,
            pointSize: size.rawValue,
            color: color,
            highlightColor: highlightColor
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpImage(
        with imageName: UIImage.Beskar.Name.System,
        pointSize: CGFloat,
        color: UIColor,
        highlightColor: UIColor
    ) {
        setImage(
            UIImage.beskar
                .create(imageName)?
                .withTintColor(
                    color,
                    renderingMode: .alwaysOriginal
            ), for: .normal
        )

        setImage(
            UIImage.beskar
                .create(imageName)?
                .withTintColor(
                    highlightColor,
                    renderingMode: .alwaysOriginal
            ), for: .highlighted
        )

        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize)
        setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .highlighted)
        imageView?.contentMode = .scaleAspectFit
    }
}
