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

    @Published var title = "REGISTER_TITLE".localized
    @Published var subtitle = "REGISTER_SUBTITLE".localized

    @Published var passwordPlaceholder = "PASSWORD_PLACEHOLDER".localized
    @Published var repeatPlaceholder = "REPEAT_PASSWORD_PLACEHOLDER".localized

    let validationResult = PassthroughSubject<Void, Error>()

    // MARK: - Methods

    func validatePassword() {
        // TODO: validation!
        validationResult.send()
    }
}
