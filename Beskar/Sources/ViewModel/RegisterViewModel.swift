//
//  RegisterViewModel.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import Combine

final class RegisterViewModel {

    // MARK: - Validation Result

    enum ValidationResult {
        /// Ready to register
        case success
        /// The original password is invalid
        case passwordError(String)
        /// The repeated password is invalid
        case repeatError(String)
        /// Original password field is empty, there are no errors but the register shouldn't be enabled
        case emptyPassword
        /// Repeat password field is empty, there are no errors but the register shouldn't be enabled
        case emptyRepeatPassword

        /// Indicate if the Register should be enabled
        var shouldEnableRegister: Bool {
            switch self {
            case .success: return true
            default: return false
            }
        }
    }

    // MARK: - Published Properties

    /// The input password field text
    @Published var password: String?
    /// The password repeated field text
    @Published var repeatPassword: String?

    /// Password validation
    var passwordValidation: AnyPublisher<ValidationResult, Never> {
        $password.combineLatest($repeatPassword) { password, repeatPassword in
            guard
                let password = password,
                password.isNotEmpty
            else {
                return .emptyPassword
            }

            guard RegexValidator.eval(
                    password,
                    for: .password,
                    trim: true
            ) else {
                return .passwordError("PASSWORD_ERROR".localized)
            }

            guard
                let repeatPassword = repeatPassword,
                repeatPassword.isNotEmpty
            else {
                return .emptyRepeatPassword
            }

            guard password.elementsEqual(repeatPassword) else {
                return .repeatError("REPEAT_PASSWORD_ERROR".localized)
            }

            return .success
        }.eraseToAnyPublisher()
    }

    // MARK: - View Data

    private(set) var title = "REGISTER_TITLE".localized
    private(set) var subtitle = "REGISTER_SUBTITLE".localized
    private(set) var buttonTitle = "REGISTER_BUTTON_TITLE".localized

    private(set) var passwordPlaceholder = "PASSWORD_PLACEHOLDER".localized
    private(set) var repeatPlaceholder = "REPEAT_PASSWORD_PLACEHOLDER".localized

    // MARK: - Methods

    func setUpData(on view: RegisterView) {
        view.titleLabel.text = title
        view.subtitleLabel.text = subtitle
        view.passwordField.placeholder = passwordPlaceholder
        view.repeatPasswordField.placeholder = repeatPlaceholder
        view.registerButton.titleText = buttonTitle
    }
}
