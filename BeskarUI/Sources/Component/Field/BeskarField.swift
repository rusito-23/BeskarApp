//
//  BeskarField.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

open class BeskarField: UIView {

    // MARK: - Types

    public struct Message {
        var message: String
        var kind: Kind

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
                UIImage(systemName: imageName)
            }

            private var imageName: String {
                switch self {
                case .success: return "checkmark.icon"
                case .warning: return "exclamationmark.triangle"
                case .error: return "xmark.octagon"
                }
            }
        }
    }

    // MARK: - Subviews

    public lazy var textField = BeskarTextField()

    private lazy var messageLabel: BeskarLabel = {
        let label = BeskarLabel(
            size: .extraSmall,
            color: UIColor.beskar.success
        )
        label.textAlignment = .left
        return label
    }()

    private lazy var messageAccessory: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var messageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            messageAccessory,
            messageLabel
        ])
        stack.spacing = Spacing.small.rawValue
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isHidden = true
        return stack
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            textField,
            messageStack
        ])
        stack.spacing = Spacing.small.rawValue
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Initializers

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

    // MARK: - Public Methods

    public func add(message: Message) {
        messageLabel.text = message.message
        messageLabel.textColor = message.kind.color
        messageAccessory.image = message.kind.image
        messageAccessory.tintColor = message.kind.color
        messageStack.isHidden = false
    }

    public func clear() {
        messageStack.isHidden = true
    }

    // MARK: - Private Methods

    private func setUpViews() {
        addSubview(contentStack)

        // Content Stack constraints
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        // Accessory constraints
        NSLayoutConstraint.activate([
            messageAccessory.heightAnchor.constraint(
                equalToConstant: Dimension.small.rawValue
            ),
            messageAccessory.widthAnchor.constraint(
                equalToConstant: Dimension.small.rawValue
            ),
        ])
    }
}
