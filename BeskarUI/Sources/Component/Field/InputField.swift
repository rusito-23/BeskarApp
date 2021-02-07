//
//  InputField.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import Combine
import UIKit

/// Input Field
/// Custom view that contains:
///     - a text field
///     - a message view
/// Using the Beskar Design System
/// Includes helpers to be used with Combine

open class InputField: UIView {

    // MARK: Public Properties

    /// Text Field Placeholder, automatically uses design system colors
    public var placeholder: String? {
        get { textField.attributedPlaceholder?.string }
        set { textField.attributedPlaceholder = NSAttributedString(
            string: newValue ?? "",
            attributes: placeholderAttributes
        )}
    }

    /// Text Field Publisher to be used with Combine, triggered on textDidChangeNotification
    public var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap { $0.object as? UITextField }
            .map { $0.text }
            .eraseToAnyPublisher()
    }


    // MARK: Private Properties

    private var placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.beskar.secondary,
        .font: UIFont.beskar.build(.extraSmall)
    ]

    // MARK: Subviews

    internal lazy var textField = TextField()

    internal lazy var messageView: FieldMessage = {
        let view = FieldMessage()
        view.hide()
        return view
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            textField,
            messageView
        ])
        stack.spacing = Spacing.small.rawValue
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

        setUpViews()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    public func showMessage(_ message: String, kind: FieldMessage.Kind) {
        messageView.show(message: message, with: kind)
    }

    public func hideMessage() {
        messageView.hide()
    }

    // MARK: Private Methods

    private func setUpViews() {
        addSubview(contentStack)

        // Content Stack constraints
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
