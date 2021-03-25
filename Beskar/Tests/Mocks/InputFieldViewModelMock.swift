//
//  InputFieldViewModelMock.swift
//  BeskarTests
//
//  Created by Igor on 25/03/2021.
//
// swiftlint:disable colon

import Combine
import BeskarUI
import BeskarKit
@testable import Beskar

class InputFieldViewModelMock: InputFieldViewModelProtocol {

    // MARK: Properties

    @Published var messages: [Message] = []

    // MARK: Protocol Conformance

    var isValid: Bool = false

    lazy var messagesPublisher: AnyPublisher<[Message], Never> = $messages.eraseToAnyPublisher()

    func validate(_ value: String?) {}
}

// MARK: - Concrete Input Field View Models

final class NameInputFieldViewModelMock:
    InputFieldViewModelMock,
    NameInputFieldViewModelProtocol {}

final class DescriptionInputFieldViewModelMock:
    InputFieldViewModelMock,
    NameInputFieldViewModelProtocol {}

final class CurrencyInputFieldViewModelMock:
    InputFieldViewModelMock,
    CurrencyInputFieldViewModelProtocol {
    func validate(_ value: Currency?) {}
}
