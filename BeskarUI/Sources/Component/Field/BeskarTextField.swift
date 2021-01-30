//
//  BeskarTextField.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

open class BeskarTextField: UITextField {

    // MARK: - Constants

    static let padding = UIEdgeInsets(
        top: .zero,
        left: Spacing.medium.rawValue,
        bottom: .zero,
        right: Spacing.medium.rawValue
    )

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

        setUpLayer()
        setUpConstraints()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setUpLayer() {
        layer.borderWidth = Border.Width.small.rawValue
        layer.borderColor = UIColor.beskar.primary.cgColor
        layer.cornerRadius = Border.Radius.medium.rawValue
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(
                equalToConstant: Dimension.medium.rawValue
            )
        ])
    }

    // MARK: - Text Rect

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Self.padding)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Self.padding)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Self.padding)
    }
}

