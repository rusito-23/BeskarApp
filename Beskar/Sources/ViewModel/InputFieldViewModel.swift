//
//  InputFieldViewModel.swift
//  Beskar
//
//  Created by Igor on 12/03/2021.
//

import BeskarUI
import Combine

// MARK: - Input Field View Model Protocol

protocol InputFieldViewModelProtocol {
    var isValid: Bool { get }
    var messagesPublisher: AnyPublisher<[Message], Never> { get }

    func validate(_ value: String?)
}

// MARK: - Input Field View Model Implementation

/// Form Input Field View Model
///
/// # Discussion #
/// An util to be used with Combine to capture the validation logic
/// and publish an array of messages that need to be displayed on the field.
class InputFieldViewModel: InputFieldViewModelProtocol {

    // MARK: Published Properties

    /// The messages to be shown in the field
    @Published var messages: [Message] = []

    /// An extra publisher for the messages to conform the protocol
    private(set) lazy var messagesPublisher = $messages.eraseToAnyPublisher()

    // MARK: Properties

    /// Indicates if all the validations passed
    /// Initial value is `false` if the field is required, `true` otherwise
    var isValid: Bool

    /// Indicates if the field can be nil or empty at any point
    let isRequired: Bool

    /// The field view model delegate
    weak var delegate: InputFieldViewModelDelegate?

    // MARK: Private Properties

    /// An array with Validations to be checked every time the value changes
    private let validations: [FieldValidationProtocol]

    // MARK: Initializer

    init(
        isRequired: Bool,
        validations: [FieldValidationProtocol] = [],
        delegate: InputFieldViewModelDelegate? = nil
    ) {
        self.isRequired = isRequired
        self.isValid = !isRequired
        self.validations = validations
        self.delegate = delegate
    }

    // MARK: Methods

    /// Runs the validations and updates the messages
    func validate(_ value: String?) {
        messages.removeAll()

        guard !value.isNilOrEmpty else {
            if isRequired {
                let message = Message("VALIDATION_REQUIRED".localized, .error)
                messages.append(message)
            }

            // re-set validation
            isValid = !isRequired
            return
        }

        validations.forEach { validation in
            if !validation.eval(string: value) {
                let message = Message(validation.failureMessage, .error)
                messages.append(message)
            }
        }

        isValid = messages.map { $0.kind == .error }.isEmpty
        delegate?.inputFieldViewModel(self, didFinishValidations: true)
    }
}

// MARK: - Field View Model Parent Delegate

protocol InputFieldViewModelDelegate: class {
    func inputFieldViewModel(
        _ viewModel: InputFieldViewModel,
        didFinishValidations: Bool
    )
}
