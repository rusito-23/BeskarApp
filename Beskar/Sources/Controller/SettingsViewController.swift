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
        form
        +++ Section("SETTINGS_SECURITY_SECTION_TITLE".localized)
        +++ SwitchRow {
                $0.title = "SETTINGS_BLOCK_SCREEN".localized
                $0.value = Preferences.blockScreenOnBackground
            }.onChange {
                guard let value = $0.value else { return }
                Preferences.blockScreenOnBackground = value
            } <<< TextRow {
                $0.title = "SETTINGS_BLOCK_SCREEN_DETAIL".localized
            }
        +++ IntRow {
                $0.title = "SETTINGS_AUTH_TIMEOUT".localized
                $0.value = Preferences.authMinutesTimeout
                $0.formatter = nil
            }.onChange {
                guard let value = $0.value else { return }
                Preferences.authMinutesTimeout = value
            } <<< TextRow {
                $0.title = "SETTINGS_AUTH_TIMEOUT_DETAIL".localized
            }
    }
}

/// Form View Controller Commons in an Extension
extension SettingsViewController {
    /// Setup the section title style with Beskar font and colors
    func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.font = UIFont.beskar.build(.small)
            headerView.textLabel?.textColor = UIColor.beskar.primary
        }
    }
}
