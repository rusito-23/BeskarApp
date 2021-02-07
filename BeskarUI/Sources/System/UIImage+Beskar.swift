//
//  UIImage+Beskar.swift
//  BeskarUI
//
//  Created by Igor on 07/02/2021.
//

import UIKit

extension UIImage: BeskarNamespace {}
extension BeskarWrapper where Base == UIImage {

    // MARK: Names By Kind

    public struct Name {
        public enum System: String {
            case success = "checkmark.icon"
            case warning = "exclamationmark.triangle"
            case error = "xmark.octagon"
        }

        public enum Custom: String {
            case clearIcon = "clear_icon"
        }
    }

    // MARK: Static Colors

    public static var success: UIImage? { with(.success) }

    public static var warning: UIImage? { with(.warning) }

    public static var error: UIImage? { with(.error) }

    public static var clearIcon: UIImage? { with(.error) }

    // MARK: Builder Methods

    public static func with(_ systemName: Name.System) -> UIImage? {
        UIImage(systemName: systemName.rawValue)
    }

    public static func with(_ name: Name.Custom) -> UIImage? {
        UIImage(named: name.rawValue)
    }
}
