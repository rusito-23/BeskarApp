//
//  MessageView.swift
//  BeskarUI
//
//  Created by Igor on 31/01/2021.
//

import UIKit

/// Convenience name for a kind and a string
public typealias Message = (message: String, kind: MessageKind)

/// A kind that identifies the quality of the message
public enum MessageKind {
    case success
    case warning
    case error

    fileprivate var color: UIColor {
        switch self {
        case .success: return UIColor.beskar.success
        case .warning: return UIColor.beskar.warning
        case .error: return UIColor.beskar.error
        }
    }

    fileprivate var image: UIImage? {
        switch self {
        case .success: return UIImage.beskar.create(.success)
        case .warning: return UIImage.beskar.create(.warning)
        case .error: return UIImage.beskar.create(.error)
        }
    }
}

/// Beskar Design System Message View
///
/// # Description #
/// Custom view built to show a generic message with a given color and image
public class MessageView: UIView {

    // MARK: Subviews

    private lazy var messageLabel = Label(
        size: .extraSmall,
        color: UIColor.beskar.success,
        alignment: .left
    )

    private lazy var messageAccessory: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var messageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            messageAccessory,
            messageLabel,
        ])
        stack.spacing = Spacing.small.rawValue
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: Initializers

    public init(message: Message) {
        super.init(frame: .zero)
        setUpMessage(message)
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpMessage(_ message: Message) {
        messageLabel.text = message.message
        messageLabel.textColor = message.kind.color
        messageAccessory.image = message.kind.image
        messageAccessory.tintColor = message.kind.color
    }

    private func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageStack)

        // Stack view constraints
        NSLayoutConstraint.activate([
            messageStack.topAnchor.constraint(equalTo: topAnchor),
            messageStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        // Accessory constraints
        NSLayoutConstraint.activate([
            messageAccessory.heightAnchor.constraint(equalToConstant: Size.small.rawValue),
            messageAccessory.widthAnchor.constraint(equalToConstant: Size.small.rawValue),
        ])
    }
}
