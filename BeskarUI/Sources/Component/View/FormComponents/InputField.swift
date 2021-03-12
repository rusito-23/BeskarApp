//
//  InputField.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import Combine
import UIKit

/// Beskar Design System Form Input Field
///
/// # Description #
/// Custom view that contains a text field & a message view.
/// 
/// # Note #
/// Includes helpers to be used with Combine
public class InputField: UIView {

    // MARK: Types

    private struct Constants {
        struct PlaceholderAnimation {
            static let duration = 0.3
        }
    }

    // MARK: Public Properties

    /// Text Field Publisher to be used with Combine, triggered on textDidChangeNotification
    public var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap { $0.object as? UITextField }
            .map { $0.text }
            .eraseToAnyPublisher()
    }

    public var messages: [Message] = [] {
        didSet {
            removeMessages()
            messages.forEach { addMessage($0) }
            layoutIfNeeded()
        }
    }

    // MARK: Private Properties

    /// Text Field Placeholder, automatically uses design system colors
    private var placeholder: String? {
        didSet { updatePlaceholder() }
    }

    /// The text field accessibility identifier
    private var identifier: String

    private var placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.beskar.secondary,
        .font: UIFont.beskar.build(.extraSmall),
    ]

    // MARK: Subviews

    lazy var textField: TextField = {
        let textField = TextField()
        textField.delegate = self
        textField.accessibilityIdentifier = identifier
        return textField
    }()

    private lazy var titleLabel: Label = {
        let label =  Label(
            size: .extraSmall,
            color: UIColor.beskar.secondary,
            alignment: .left
        )
        label.isHidden = true
        return label
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            textField,
        ])
        stack.spacing = Spacing.small.rawValue
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: Initializers

    public init(placeholder: String, identifier: String) {
        self.placeholder = placeholder
        self.identifier = identifier
        super.init(frame: .zero)

        setUpViews()
        setUpAccessibility()
        updatePlaceholder()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func addMessage(_ message: Message) {
        let messageView = MessageView(message: message)
        messageView.accessibilityIdentifier = message.message
        accessibilityElements?.append(messageView)
        contentStack.addArrangedSubview(messageView)
    }

    public func removeMessages() {
        for view in contentStack.arrangedSubviews where view is MessageView {
            view.removeFromSuperview()
        }

        setUpAccessibility()
    }

    private func setUpViews() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentStack)

        // Content Stack constraints
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func updatePlaceholder() {
        titleLabel.text = placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: placeholderAttributes
        )
    }

    private func setUpAccessibility() {
        isAccessibilityElement = false
        accessibilityElements = [textField]
    }
}

// MARK: UITextFieldDelegate

extension InputField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: Constants.PlaceholderAnimation.duration) {
            self.titleLabel.isHidden = false
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            UIView.animate(withDuration: Constants.PlaceholderAnimation.duration) {
                self.titleLabel.isHidden = true
            }
        }
    }
}
