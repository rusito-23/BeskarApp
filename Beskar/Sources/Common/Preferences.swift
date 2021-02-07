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
    }

    // MARK: Getters & Setters

    static var isNotFirstLaunch: Bool {
        get { defaults.bool(forKey: Kind.isNotFirstLaunch.rawValue) }
        set { defaults.set(newValue, forKey: Kind.isNotFirstLaunch.rawValue) }
    }
}
