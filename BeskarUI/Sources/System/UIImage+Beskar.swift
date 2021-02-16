//
//  UIImage+Beskar.swift
//  BeskarUI
//
//  Created by Igor on 07/02/2021.
//
// Beskar Design System Reusable Images

import UIKit

extension UIImage: BeskarNamespace {}
extension BeskarWrapper where Base == UIImage {

    // MARK: Names By Kind

    public struct Name {
        public enum System: String {
            // Messages
            case success = "checkmark.icon"
            case warning = "exclamationmark.triangle"
            case error = "xmark.octagon"

            // Tab Icons
            case settings = "gearshape"
            case wallets = "wallet.pass"
            case analytics = "chart.bar.xaxis"

            // Actions
            case deposit = "plus.circle"
            case withdraw = "minus.circle"
            case details = "list.dash"
            case create = "plus.circle.fill"

            // Other
            case wip = "wrench.and.screwdriver"
        }

        public enum Custom: String {
            case clearIcon = "icon-clear"
        }
    }

    // MARK: Builder Methods

    public static func create(_ systemName: Name.System) -> UIImage? {
        UIImage(systemName: systemName.rawValue)
    }

    public static func create(_ name: Name.Custom) -> UIImage? {
        UIImage(named: name.rawValue)
    }
}
