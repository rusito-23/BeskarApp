//
//  Preferences.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import BeskarKit
import Foundation

struct Preferences {

    // MARK: Properties

    private static var defaults: UserDefaults { .standard }

    // MARK: Kind

    enum Kind: String {
        case isNotFirstLaunch = "is_first_launch"
        case authMinutesTimeout = "auth_minutes_timeout"
        case blockScreenOnBackground = "block_screen_on_background"
    }

    // MARK: Getters & Setters

    static var isNotFirstLaunch: Bool {
        get { defaults.bool(forKey: Kind.isNotFirstLaunch.rawValue) }
        set { defaults.set(newValue, forKey: Kind.isNotFirstLaunch.rawValue) }
    }

    static var authMinutesTimeout: Int {
        get { defaults.integer(forKey: Kind.authMinutesTimeout.rawValue) }
        set { defaults.set(newValue, forKey: Kind.authMinutesTimeout.rawValue) }
    }

    static var blockScreenOnBackground: Bool {
        get { defaults.bool(forKey: Kind.blockScreenOnBackground.rawValue) }
        set { defaults.set(newValue, forKey: Kind.blockScreenOnBackground.rawValue) }
    }
}
