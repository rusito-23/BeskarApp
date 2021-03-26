//
//  InputFieldViewModelTests.swift
//  BeskarTests
//
//  Created by Igor on 26/03/2021.
//

import BeskarUI
import Nimble
import XCTest
@testable import Beskar

final class InputFieldViewModelTests: XCTestCase {

    // MARK: Tests

    func test_requiredField_withNilValue_shouldFail() {
        let viewModel = InputFieldViewModel(isRequired: true)
        viewModel.validate(nil)
        expect(viewModel.isValid).to(beFalse())
    }

    func test_requiredField_withNonNilValueAndEmptyValidations_shouldNotFail() {
        let viewModel = InputFieldViewModel(isRequired: true)
        viewModel.validate("SOME FIELD")
        expect(viewModel.isValid).to(beTrue())
    }

    func test_optionalField_withNilValue_shouldSucceed() {
        let viewModel = InputFieldViewModel(isRequired: false)
        viewModel.validate(nil)
        expect(viewModel.isValid).to(beTrue())
    }

    func test_optionalField_withNonNilValueAndEmptyValidations_shouldSucceed() {
        let viewModel = InputFieldViewModel(isRequired: false)
        viewModel.validate(nil)
        expect(viewModel.isValid).to(beTrue())
    }

    func test_requiredField_withFailedValidation_shouldFail() {
        let validationMock = FieldValidationMock()
        let viewModel = InputFieldViewModel(isRequired: true, validations: [validationMock])
        viewModel.validate("SOME FIELD")
        validationMock.isValid = false
        expect(viewModel.isValid).to(beFalse())
    }

    func test_requiredField_withValidationSuccess_shouldSucceed() {
        let validationMock = FieldValidationMock()
        let viewModel = InputFieldViewModel(isRequired: true, validations: [validationMock])
        viewModel.validate("SOME FIELD")
        validationMock.isValid = true
        expect(viewModel.isValid).to(beFalse())
    }

    func test_optionalField_withFailedValidation_shouldFail() {
        let validationMock = FieldValidationMock()
        let viewModel = InputFieldViewModel(isRequired: false, validations: [validationMock])
        viewModel.validate("SOME FIELD")
        validationMock.isValid = false
        expect(viewModel.isValid).to(beFalse())
    }

    func test_optionalField_withValidationSuccess_shouldSucceed() {
        let validationMock = FieldValidationMock()
        let viewModel = InputFieldViewModel(isRequired: false, validations: [validationMock])
        viewModel.validate("SOME FIELD")
        validationMock.isValid = true
        expect(viewModel.isValid).to(beFalse())
    }
}
