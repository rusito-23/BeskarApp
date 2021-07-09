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
/// Uses the SF System Icons and uses them with a large point size, all configured from
/// within this view. Uses `tertiary` tinto color for normal state and `secondary` for highlighted.
public class ActionButton: UIButton {

    // MARK: Properties

    private let pointSize: CGFloat

    private let color: UIColor

    private let highlightColor: UIColor

    // MARK: Initializers

    public init(
        imageName: UIImage.Beskar.Name.System? = nil,
        size: UIFont.Beskar.Size = .typeMedium,
        color: UIColor = UIColor.beskar.tertiary,
        highlightColor: UIColor = UIColor.beskar.secondary,
        identifier: String? = nil,
        label: String? = nil
    ) {
        self.pointSize = size.rawValue
        self.color = color
        self.highlightColor = highlightColor

        super.init(frame: .zero)
        accessibilityIdentifier = identifier
        accessibilityLabel = label

        if let imageName = imageName { update(with: imageName) }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    public func update(with imageName: UIImage.Beskar.Name.System) {
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
