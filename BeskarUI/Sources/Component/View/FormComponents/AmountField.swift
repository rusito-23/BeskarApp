//
//  AmountField.swift
//  BeskarUI
//
//  Created by Igor on 13/03/2021.
//

import Foundation
import UIKit

/// Beskar Amount Field
///
/// # Discussion #
/// A component to take a money user input
public class AmountField: UITextField {

    // MARK: Properties

    /// The amount represented in the text field as a Double
    /// This should be used instead of the default string value
    public var amount: Double? {
        get {
            guard
                let numberRegex = numberRegex,
                let text = text
            else { return nil }

            return (numberRegex.stringByReplacingMatches(
                in: text,
                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                range: NSRange(text.startIndex..., in: text),
                withTemplate: ""
            ) as NSString).doubleValue / 100
        }

        set {
            guard let amount = newValue else { return }
            let amountNumber = NSNumber(value: amount)
            text = numberFormatter.string(from: amountNumber)
        }
    }

    // MARK: Private properties

    private var currencySymbol: String?

    private var doneButtonText: String?

    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currencySymbol ?? ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()

    private lazy var numberRegex = try? NSRegularExpression(
        pattern: "[^0-9]",
        options: .caseInsensitive
    )

    // MARK: Subviews

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.backgroundColor = UIColor.beskar.base
        toolBar.tintColor = UIColor.beskar.primary
        toolBar.setItems([toolBarDoneButton], animated: false)
        toolBar.sizeToFit()
        return toolBar
    }()

    private lazy var toolBarDoneButton = UIBarButtonItem(
        title: doneButtonText,
        style: .plain,
        target: self,
        action: #selector(onDoneTapped)
    )

    // MARK: Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpKeyboard()
        setUpStyle()
        setUpActions()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Setup Methods

    private func setUpStyle() {
        font = UIFont.beskar.build(.extraLarge)
        tintColor = UIColor.beskar.white
        textAlignment = .center
    }

    private func setUpKeyboard() {
        keyboardType = .numberPad
        inputAccessoryView = toolBar
    }

    private func setUpActions() {
        addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
    }

    // MARK: Private Methods

    private func updateAmountText() {
        guard let amount = amount else { return }
        self.amount = amount
    }

    // MARK: Private Actions

    @objc private func textDidChange() {
        updateAmountText()
    }

    @objc private func onDoneTapped() {
        resignFirstResponder()
    }
}
