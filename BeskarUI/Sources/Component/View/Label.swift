//
//  Label.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

/// Beskar Design System Label
///
/// # Description #
/// Helpers to facilitate the usage of the design system label
/// by initializing the label with Beskar Fonts and Colors.

public class Label: UILabel {

    // MARK: Initializers

    public init(
        size: UIFont.Beskar.Size,
        weight: UIFont.Beskar.Weight = .init(),
        color: UIColor = UIColor.beskar.primary,
        text: String? = nil,
        identifier: String? = nil,
        label: String? = nil
    ) {
        super.init(frame: .zero)

        accessibilityIdentifier = identifier
        accessibilityLabel = label

        translatesAutoresizingMaskIntoConstraints = false

        font = UIFont.beskar.build(size, weight)
        textColor = color
        self.text = text

        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        textAlignment = .center
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
