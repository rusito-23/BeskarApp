//
//  PickerInputField.swift
//  BeskarUI
//
//  Created by Igor on 11/03/2021.
//

import Combine
import UIKit

/// Form Picker Input Option
///
/// # Description #
/// A protocol that defines the options that need to be used from within the input picker.
public protocol PickerInputOption {
    var displayName: String { get }
}

/// Beskar Design System Form Picker Input Field
///
/// # Description #
/// Custom view that contains a text field & a message view.
/// This view has the capability to handle the input through a Picker.
/// The associated type `Option`needs to conform to `FormPickerInputOption` to provide a display name.
///
/// # Note #
/// Includes helpers to be used with Combine
public class PickerInputField<
    OptionType: PickerInputOption
>: InputField, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Public Properties

    public var options: [OptionType] = []

    @Published public var selected: OptionType? {
        didSet { textField.text = selected?.displayName }
    }

    /// Text Field Publisher to be used with Combine, triggered on textDidChangeNotification
    public override var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap { $0.object as? UITextField }
            .map { $0.text }
            .eraseToAnyPublisher()
    }

    // MARK: Subviews

    private lazy var itemPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.beskar.base
        return pickerView
    }()

    // MARK: Initializer

    public init(placeholder: String, identifier: String) {
        super.init(placeholder: placeholder, identifier: identifier)
        setUpInputView()
    }

    // MARK: Private Methods

    private func setUpInputView() {
        textField.inputView = itemPicker
    }

    // MARK: Picker View Datasource Conformance

    /// We only support a single component currently
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    /// The number of rows is given by the option count
    public func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int { options.count }

    // MARK: Picker View Delegate Conformance

    /// We title is the given display name
    public func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? { options[row].displayName }

    /// Set the selected component and resign the first responder
    public func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        selected = options[row]
        textField.resignFirstResponder()
    }
}
