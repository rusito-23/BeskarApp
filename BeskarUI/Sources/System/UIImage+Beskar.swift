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
        public enum System {
            case message(MessageKind)
            case tabIcon(TabIcon)

            public enum MessageKind: String {
                case success = "checkmark.icon"
                case warning = "exclamationmark.triangle"
                case error = "xmark.octagon"
            }

            public enum TabIcon: String {
                case settings = "gearshape"
                case wallets = "wallet.pass"
                case analytics = "chart.bar.xaxis"
            }
        }

        public enum Custom: String {
            case clearIcon = "clear_icon"
        }
    }

    // MARK: Builder Methods

    public static func create(_ systemName: Name.System) -> UIImage? {
        switch systemName {
        case let .message(name):
            return UIImage(systemName: name.rawValue)
        case let .tabIcon(name):
            return UIImage(systemName: name.rawValue)
        }
    }

    public static func create(_ name: Name.Custom) -> UIImage? {
        UIImage(named: name.rawValue)
    }
}
