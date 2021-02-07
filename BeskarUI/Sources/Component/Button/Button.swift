//
//  Button.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

/// Beskar Design System Button
/// Provides an easy interface to use the design system button, with
/// two kinds available: `primary` and `secondary

public class Button: UIButton {

    // MARK: Types

    public enum Kind {
        case primary
        case secondary
    }

    // MARK: Properties

    public var titleText: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }

    // MARK: Initializers

    public init(
        kind: Kind,
        title: String? = nil
    ) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)

        setUp(with: kind)
        setUpLayer()
        setUpConstraints()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpLayer() {
        layer.borderWidth = Border.Width.small.rawValue
        layer.cornerRadius = Border.Radius.medium.rawValue
    }

    private func setUp(with kind: Kind) {
        switch kind {
        case .primary:
            titleLabel?.font = UIFont.beskar.build(.extraSmall, .traitExpanded)
            layer.borderColor = UIColor.beskar.secondary.cgColor
            backgroundColor = UIColor.beskar.primary
            setTitleColor(UIColor.beskar.tertiary, for: .normal)
            setTitleColor(UIColor.beskar.baseInverted, for: .disabled)
            setTitleColor(UIColor.beskar.baseInverted, for: .highlighted)
        case .secondary:
            titleLabel?.font = UIFont.beskar.build(.extraSmall)
            layer.borderColor = UIColor.beskar.primary.cgColor
            backgroundColor = UIColor.beskar.base
            setTitleColor(UIColor.beskar.primary, for: .normal)
            setTitleColor(UIColor.beskar.secondary, for: .disabled)
            setTitleColor(UIColor.beskar.secondary, for: .highlighted)
        }
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(
                equalToConstant: Dimension.medium.rawValue
            )
        ])
    }
}
