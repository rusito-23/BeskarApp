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
        case sessionTimeoutInMinutes = "session_timeout_in_minutes"
        case blockScreenOnBackground = "block_screen_on_background"
        case sessionPauseDate = "session_pause_date"
        case shouldForceLogin = "should_force_login"
    }

    // MARK: Getters & Setters

    static var isNotFirstLaunch: Bool {
        get { defaults.bool(forKey: Kind.isNotFirstLaunch.rawValue) }
        set { defaults.set(newValue, forKey: Kind.isNotFirstLaunch.rawValue) }
    }

    static var sessionTimeoutInMinutes: Int {
        get { defaults.integer(forKey: Kind.sessionTimeoutInMinutes.rawValue) }
        set { defaults.set(newValue, forKey: Kind.sessionTimeoutInMinutes.rawValue) }
    }

    static var blockScreenOnBackground: Bool {
        get { defaults.bool(forKey: Kind.blockScreenOnBackground.rawValue) }
        set { defaults.set(newValue, forKey: Kind.blockScreenOnBackground.rawValue) }
    }

    static var sessionPauseDate: Date {
        get { Date(timeIntervalSince1970: defaults.double(forKey: Kind.sessionPauseDate.rawValue)) }
        set { defaults.set(newValue.timeIntervalSince1970, forKey: Kind.sessionPauseDate.rawValue) }
    }

    static var shouldForceLogin: Bool {
        get { defaults.bool(forKey: Kind.shouldForceLogin.rawValue) }
        set { defaults.set(newValue, forKey: Kind.shouldForceLogin.rawValue) }
    }
}
