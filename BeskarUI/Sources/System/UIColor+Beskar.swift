//
//  UIColor+Beskar.swift
//  Beskar
//
//  Created by Igor on 28/01/2021.
//
//  Design System Colors

import UIKit.UIColor

extension UIColor: BeskarNamespace {}
public extension BeskarWrapper where Base: UIColor {

    // MARK: - Base

    static var base: UIColor { .systemGray6 }

    static var baseInverted: UIColor { .systemGray }

    static var primary: UIColor { .systemOrange }

    static var secondary: UIColor { .systemGray }

    static var tertiary: UIColor { .black }

    // MARK: - Info

    static var success: UIColor { .systemGreen }

    static var error: UIColor { .systemRed }

    static var info: UIColor { .systemBlue }

    static var warning: UIColor { .systemYellow }
}
