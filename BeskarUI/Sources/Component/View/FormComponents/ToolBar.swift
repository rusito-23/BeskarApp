//
//  ToolBar.swift
//  BeskarUI
//
//  Created by Igor on 21/03/2021.
//

import UIKit

final class ToolBar: UIToolbar {

    // MARK: Types

    enum Kind {
        case cancel
        case done

        var localizedMessage: String {
            switch self {
            case .cancel: return "CANCEL".localized
            case .done: return "DONE".localized
            }
        }
    }

    // MARK: Properties

    /// A weak reference to the text field owner of the toolbar
    private weak var textField: UITextField?

    /// The kind of tool bar - this will control the localized button text and action
    private var kind: Kind

    // MARK: Subviews

    private lazy var actionButton = UIBarButtonItem(
        title: kind.localizedMessage,
        style: .plain,
        target: self,
        action: #selector(onActionButtonTapped)
    )

    private lazy var flexSpace = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil
    )

    // MARK: Initializer

    init(kind: Kind = .done, textField: UITextField? = nil) {
        self.kind = kind
        self.textField = textField
        super.init(frame: .zero)
        setUpStyle()
        setUpActions()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setUpStyle() {
        barStyle = .default
        backgroundColor = UIColor.beskar.base
        tintColor = UIColor.beskar.primary
        sizeToFit()
    }

    private func setUpActions() {
        setItems([flexSpace, actionButton], animated: true)
    }

    // MARK: Private Actions

    @objc private func onActionButtonTapped() {
        textField?.resignFirstResponder()
    }
}
