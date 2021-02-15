//
//  FieldMessage.swift
//  BeskarUI
//
//  Created by Igor on 31/01/2021.
//

import UIKit

/// Beskar Design System Field Message
///
/// # Description #
/// Custom view that shows a message in an input Field, with a three available kinds:
/// `success`, `warning` or `error`

public class FieldMessage: UIView {

    // MARK: Types

    public enum Kind {
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
            case .warning: return UIImage.beskar.create(.success)
            case .error: return UIImage.beskar.create(.success)
            }
        }
    }

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

    override public init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    public func show(message: String, with kind: Kind) {
        messageLabel.text = message
        messageLabel.textColor = kind.color
        messageAccessory.image = kind.image
        messageAccessory.tintColor = kind.color
        isHidden = false
    }

    public func hide() {
        messageLabel.text = nil
        messageLabel.textColor = nil
        messageAccessory.image = nil
        messageAccessory.tintColor = nil
        isHidden = true
    }

    // MARK: Private Methods

    private func setUpViews() {
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