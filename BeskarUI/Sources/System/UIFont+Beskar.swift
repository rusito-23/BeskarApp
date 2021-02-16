//
//  UIFont+Beskar.swift
//  BeskarUI
//
//  Created by Igor on 30/01/2021.
//
// Beskar Design System Fonts

import UIKit.UIFont

extension UIFont: BeskarNamespace {}
public extension BeskarWrapper where Base == UIFont {

    // MARK: Types

    enum Size: CGFloat {
        case extraLarge = 64.0
        case large = 46.0
        case typeLarge = 36.0
        case medium = 32.0
        case typeMedium = 27.0
        case small = 23.0
        case extraSmall = 17.0
        case tiny = 12.0
    }

    typealias Weight = UIFontDescriptor.SymbolicTraits

    // MARK: Constants

    private static var name: String { "AvenirNext-Heavy" }

    // MARK: - Builder

    static func build(
        _ size: Size,
        _ weight: Weight = .init()
    ) -> UIFont {
        guard let descriptor = UIFontDescriptor(fontAttributes: [.name: name])
            .withSize(size.rawValue)
            .withSymbolicTraits(weight)
        else { return .systemFont(ofSize: size.rawValue) }

        return UIFont(descriptor: descriptor, size: size.rawValue)
    }
}
