//
//  RegisterViewModel.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import Combine

final class RegisterViewModel {

    // MARK: - Combine

    @Published var password: String?

    let validationResult = PassthroughSubject<Void, Error>()

    private(set) var title = "REGISTER_TITLE".localized
    private(set) var subtitle = "REGISTER_SUBTITLE".localized
    private(set) var buttonTitle = "REGISTER_BUTTON_TITLE".localized

    private(set) var passwordPlaceholder = "PASSWORD_PLACEHOLDER".localized
    private(set) var repeatPlaceholder = "REPEAT_PASSWORD_PLACEHOLDER".localized

    // MARK: - Methods

    func validatePassword() {
        // TODO: validation!
        validationResult.send()
    }
}
