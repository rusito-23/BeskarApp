//
//  TextField.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit
import TinyConstraints

/// Beskar Design System Text Field
public class TextField: UITextField {

    // MARK: Properties

    private var doneButtonText: String?

    // MARK: Subviews

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.backgroundColor = UIColor.beskar.base
        toolBar.tintColor = UIColor.beskar.primary
        toolBar.setItems([toolBarDoneButton], animated: false)
        toolBar.sizeToFit()
        return toolBar
    }()

    private lazy var toolBarDoneButton = UIBarButtonItem(
        title: doneButtonText,
        style: .plain,
        target: self,
        action: #selector(onDoneTapped)
    )

    // MARK: Initializers

    public init(doneButtonText: String?) {
        self.doneButtonText = doneButtonText
        super.init(frame: .zero)

        setUpKeyboard()
        setUpLayer()
        setUpConstraints()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Setup Methods

    private func setUpKeyboard() {
        inputAccessoryView = toolBar
    }

    private func setUpLayer() {
        layer.borderWidth = Border.Width.small.rawValue
        layer.borderColor = UIColor.beskar.primary.cgColor
        layer.cornerRadius = Border.Radius.medium.rawValue
    }

    private func setUpConstraints() {
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        height(Size.medium.rawValue)
    }

    // MARK: Private Text Rect Insets Overrides

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets.beskar.horizontal(by: .medium))
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets.beskar.horizontal(by: .medium))
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets.beskar.horizontal(by: .medium))
    }

    // MARK: Private Actions

    @objc func onDoneTapped(_ sender: UIBarButtonItem) {
        resignFirstResponder()
    }
}
