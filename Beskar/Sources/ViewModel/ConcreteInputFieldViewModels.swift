//
//  ConcreteInputFieldViewModel.swift
//  BeskarTests
//
//  Created by Igor on 25/03/2021.
//
// swiftlint:disable colon

import BeskarKit

// MARK: - Name Input Field View Model

protocol NameInputFieldViewModelProtocol: InputFieldViewModelProtocol {}

final class NameInputFieldViewModel:
    InputFieldViewModel,
    NameInputFieldViewModelProtocol {}

// MARK: - Description Input Field View Model

protocol DescriptionInputFieldViewModelProtocol: InputFieldViewModelProtocol {}

final class DescriptionInputFieldViewModel:
    InputFieldViewModel,
    DescriptionInputFieldViewModelProtocol {}

// MARK: - Currency Input Field View Model

protocol CurrencyInputFieldViewModelProtocol: InputFieldViewModelProtocol {
    func validate(_ value: Currency?)
}

final class CurrencyInputFieldViewModel:
    PickerInputFieldViewModel<Currency>,
    CurrencyInputFieldViewModelProtocol {}
