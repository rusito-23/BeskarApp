//
//  FormField.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import Combine
import UIKit

/// Beskar Design System Form Field
///
/// # Description #
/// Custom view that contains a text field & a message view.
/// 
/// # Note #
/// Includes helpers to be used with Combine
// TODO: add identifier to all of this stuff

open class FormField: UIView {

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

    // MARK: Private Properties

    /// Text Field Placeholder, automatically uses design system colors
    private var placeholder: String? {
        didSet { updatePlaceholder() }
    }

    private var placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.beskar.secondary,
        .font: UIFont.beskar.build(.extraSmall),
    ]

    // MARK: Subviews

    lazy var textField: TextField = {
        let textField = TextField()
        textField.delegate = self
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

    public override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
    }

    public convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        updatePlaceholder()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    public func addMessage(_ message: String, kind: FieldMessage.Kind) {
        let messageView = FieldMessage(message: message, kind: kind)
        contentStack.addArrangedSubview(messageView)
    }

    public func removeMessages() {
        for view in contentStack.arrangedSubviews where view is FieldMessage {
            view.removeFromSuperview()
        }
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

    private func updatePlaceholder() {
        titleLabel.text = placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: placeholderAttributes
        )
    }
}

// MARK: UITextFieldDelegate

extension FormField: UITextFieldDelegate {
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
