//
//  BeskarButton.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

public class BeskarButton: UIButton {

    // MARK: - Types

    public enum Kind {
        case primary
        case secondary
    }

    // MARK: - Properties

    private var kind: Kind

    // MARK: - Initializers

    public init(kind: Kind) {
        self.kind = kind
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        setUp()
        setUpLayer()
        setUpColors()
        setUpConstraints()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setUp() {
        titleLabel?.font = UIFont.beskar.build(.extraSmall)
    }

    private func setUpLayer() {
        layer.borderWidth = Border.Width.small.rawValue
        layer.cornerRadius = Border.Radius.medium.rawValue
    }

    private func setUpColors() {
        switch kind {
        case .primary:
            layer.borderColor = UIColor.beskar.secondary.cgColor
            backgroundColor = UIColor.beskar.primary
            setTitleColor(UIColor.beskar.tertiary, for: .normal)
            setTitleColor(UIColor.beskar.baseInverted, for: .highlighted)
        case .secondary:
            layer.borderColor = UIColor.beskar.primary.cgColor
            backgroundColor = UIColor.beskar.base
            setTitleColor(UIColor.beskar.primary, for: .normal)
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
