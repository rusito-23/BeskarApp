//
//  UIEdgeInsets+Beskar.swift
//  BeskarUI
//
//  Created by Igor on 31/01/2021.
//

import UIKit

extension UIEdgeInsets: BeskarNamespace {}
extension BeskarWrapper where Base == UIEdgeInsets {

    public static func horizontal(by spacing: Spacing) -> UIEdgeInsets {
        UIEdgeInsets(
            top: .zero,
            left: spacing.rawValue,
            bottom: .zero,
            right: spacing.rawValue
        )
    }

    public static func vertical(by spacing: Spacing) -> UIEdgeInsets {
        UIEdgeInsets(
            top: spacing.rawValue,
            left: .zero,
            bottom: spacing.rawValue,
            right: .zero
        )
    }

    public static func by(_ spacing: Spacing) -> UIEdgeInsets {
        UIEdgeInsets(
            top: spacing.rawValue,
            left: spacing.rawValue,
            bottom: spacing.rawValue,
            right: spacing.rawValue
        )
    }
}
