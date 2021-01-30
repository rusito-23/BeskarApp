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
        struct Image {
            struct Name {
                static let visible = "eye"
                static let invisible = "eye.slash"
            }

            static let size: CGFloat = 25
        }
    }

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        isSecureTextEntry = true
        textContentType = .password
        setUpVisibilityToggle()
    }

    // MARK: - Private

    private func setPasswordToggleImage(_ button: UIButton) {
        button.setImage(
            UIImage(
                systemName: isSecureTextEntry ?
                    Constants.Image.Name.invisible :
                    Constants.Image.Name.visible
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
            x: frame.size.width - Constants.Image.size,
            y: .zero,
            width: Constants.Image.size,
            height: Constants.Image.size
        )

        button.addTarget(
            self,
            action: #selector(self.togglePasswordView),
            for: .touchUpInside
        )

        rightView = button
        rightViewMode = .always
    }

    @objc private func togglePasswordView(_ sender: Any) {
        isSecureTextEntry = !isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
