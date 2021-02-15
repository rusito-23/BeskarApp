//
//  Label.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import Combine
import UIKit

/// Beskar Design System Label
///
/// # Description #
/// Helpers to facilitate the usage of the design system label by initializing the label with Beskar Fonts and Colors.
/// Also provides helpers to interact using the Combine framework.

public class Label: UILabel {

    // MARK: Initializers

    public init(
        size: UIFont.Beskar.Size,
        weight: UIFont.Beskar.Weight = .init(),
        color: UIColor = UIColor.beskar.primary,
        breakMode: NSLineBreakMode = .byWordWrapping,
        alignment: NSTextAlignment = .center,
        text: String? = nil,
        identifier: String? = nil,
        label: String? = nil
    ) {
        super.init(frame: .zero)

        lineBreakMode = breakMode
        textAlignment = alignment
        accessibilityIdentifier = identifier
        accessibilityLabel = label
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.beskar.build(size, weight)
        textColor = color
        self.text = text
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
