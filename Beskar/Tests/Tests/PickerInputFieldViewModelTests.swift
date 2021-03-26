//
//  PickerInputFieldViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import Nimble
import XCTest
@testable import Beskar

final class PickerInputFieldViewModelTests: XCTestCase {

    // MARK: Tests

    func test_requiredField_withNilValue_shouldFail() {
        let value: Int? = nil
        let viewModel = PickerInputFieldViewModel<Int>(isRequired: true)
        viewModel.validate(value)
        expect(viewModel.isValid).to(beFalse())
    }

    func test_requiredField_withValue_shouldSucceed() {
        let value = 23
        let viewModel = PickerInputFieldViewModel<Int>(isRequired: true)
        viewModel.validate(value)
        expect(viewModel.isValid).to(beTrue())
    }

    func test_optionalField_withNilValue_shouldSucceed() {
        let value: Int? = nil
        let viewModel = PickerInputFieldViewModel<Int>(isRequired: false)
        viewModel.validate(value)
        expect(viewModel.isValid).to(beTrue())
    }

    func test_validateString_withOptionalField_shouldNotDoAnything() {
        let viewModel = PickerInputFieldViewModel<Int>(isRequired: false)
        expect(viewModel.isValid).to(beTrue())
        viewModel.validate("Something")
        expect(viewModel.isValid).to(beTrue())
    }

    func test_validateString_withRequiredField_shouldNotDoAnything() {
        let viewModel = PickerInputFieldViewModel<Int>(isRequired: true)
        expect(viewModel.isValid).to(beFalse())
        viewModel.validate("Something")
        expect(viewModel.isValid).to(beFalse())
    }
}
