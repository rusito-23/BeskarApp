//
//  PickerInputFieldViewModel.swift
//  Beskar
//
//  Created by Igor on 12/03/2021.
//

import BeskarUI
import Combine

/// Form Picker Field View Model
///
/// # Discussion #
/// An util to be used with Combine to capture the validation logic
/// and publish an array of messages that need to be displayed on the field.
/// Only applies to a form field with a picker input
final class PickerInputFieldViewModel<OptionType>: InputFieldViewModel {

    // MARK: Methods

    /// we don't validate the string value for picker fields
    override func validate(_ value: String?) {}

    /// we validate the actual selected option
    func validate(_ value: OptionType?) {
        isValid = !(isRequired && value == nil)
        delegate?.inputFieldViewModel(self, didFinishValidations: true)
    }
}
