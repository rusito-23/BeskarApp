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
        case useBiometrics = "use_biometrics"
    }

    // MARK: - Login Method

    static var useBiometrics: Bool {
        get { defaults.bool(forKey: Kind.useBiometrics.rawValue) }
        set { defaults.set(newValue, forKey: Kind.useBiometrics.rawValue) }
    }
}
