//
//  Preferences.swift
//  Beskar
//
//  Created by Igor on 30/01/2021.
//

import BeskarKit
import Foundation

struct Preferences {

    // MARK: - Properties

    private static var defaults: UserDefaults { .standard }

    // MARK: - Kind

    enum Kind: String {
        case didShowWelcome = "did_show_welcome"
        case useBiometrics = "use_biometrics"
    }

    // MARK: - Login Method

    static var didShowWelcome: Bool {
        get { defaults.bool(forKey: Kind.didShowWelcome.rawValue) }
        set { defaults.set(newValue, forKey: Kind.didShowWelcome.rawValue) }
    }

    static var useBiometrics: Bool {
        get { defaults.bool(forKey: Kind.useBiometrics.rawValue) }
        set { defaults.set(newValue, forKey: Kind.useBiometrics.rawValue) }
    }
}
