//
//  SettingsViewController.swift
//  Beskar
//
//  Created by Igor on 09/02/2021.
//

import BeskarUI
import Eureka
import UIKit

final class SettingsViewController: FormViewController {

    // MARK: View Controller Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
        setUpForm()
    }

    // MARK: Private Methods

    private func setUpStyle() {
        view.backgroundColor = UIColor.beskar.base
    }

    private func setUpForm() {
        form +++ Section("SETTINGS_SECURITY_SECTION_TITLE".localized)
            <<< SwitchRow {
                $0.title = "SETTINGS_BLOCK_SCREEN".localized
                $0.value = Preferences.blockScreenOnBackground
            }.onChange {
                guard let value = $0.value else { return }
                Preferences.blockScreenOnBackground = value
            }
            <<< IntRow {
                $0.title = "SETTINGS_AUTH_TIMEOUT".localized
                $0.value = Preferences.authMinutesTimeout
            }.onChange {
                guard let value = $0.value else { return }
                Preferences.authMinutesTimeout = value
            }
    }
}
