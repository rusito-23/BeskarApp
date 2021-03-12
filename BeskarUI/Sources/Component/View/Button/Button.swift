//
//  Button.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

/// Beskar Design System Button
///
/// # Description #
/// Provides an easy interface to use the design system button, with
/// two kinds available: `primary` and `secondary`
public class Button: UIButton {

    // MARK: Types

    public enum Kind {
        case primary
        case secondary
    }

    // MARK: Public Properties

    public var titleText: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }

    // MARK: Private Properties

    private var kind: Kind

    private var isEnabledObserver: NSKeyValueObservation?

    // MARK: Initializers

    public init(
        kind: Kind,
        title: String? = nil,
        identifier: String? = nil,
        label: String? = nil
    ) {
        self.kind = kind
        super.init(frame: .zero)
        accessibilityIdentifier = identifier
        accessibilityLabel = label
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)

        setUpStyle()
        setUpLayer()
        setUpConstraints()
        setUpObservers()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpStyle() {
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

    private func setUpLayer() {
        layer.borderWidth = Border.Width.small.rawValue
        layer.cornerRadius = Border.Radius.medium.rawValue
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Size.medium.rawValue),
        ])
    }

    private func setUpObservers() {
        isEnabledObserver = observe(\.isEnabled, options: [.new]) { _, _  in
            switch self.kind {
            case .primary:
                self.backgroundColor = self.isEnabled ?
                    UIColor.beskar.primary :
                    UIColor.beskar.base
            case .secondary: break
            }
        }
    }
}
