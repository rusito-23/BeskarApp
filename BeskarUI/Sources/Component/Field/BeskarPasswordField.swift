//
//  BeskarPasswordField.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//

import UIKit

public final class BeskarPasswordField: BeskarField {

    // MARK: - Constants

    private struct Constants {
        struct ImageName {
            static let visible = "eye"
            static let invisible = "eye.slash"
        }
    }

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        setUpVisibilityToggle()
    }

    // MARK: - Private

    private func setPasswordToggleImage(_ button: UIButton) {
        button.setImage(
            UIImage(
                systemName: textField.isSecureTextEntry ?
                    Constants.ImageName.invisible :
                    Constants.ImageName.visible
            )?.withTintColor(UIColor.beskar.primary),
            for: .normal
        )
    }

    private func setUpVisibilityToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)

        button.imageEdgeInsets = UIEdgeInsets(
            top: .zero,
            left: -Spacing.medium.rawValue,
            bottom: .zero,
            right: .zero
        )

        button.frame = CGRect(
            x: frame.size.width - Dimension.medium.rawValue,
            y: .zero,
            width: Dimension.medium.rawValue,
            height: Dimension.medium.rawValue
        )

        button.addTarget(
            self,
            action: #selector(self.togglePasswordView),
            for: .touchUpInside
        )

        textField.rightView = button
        textField.rightViewMode = .always
    }

    @objc private func togglePasswordView(_ sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        setPasswordToggleImage(sender)
    }
}
