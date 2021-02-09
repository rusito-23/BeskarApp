//
//  MainTabBarController.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

import BeskarUI
import UIKit

final class MainTabBarController: TabBarController {

    // MARK: View Controllers

    private lazy var analyticsViewController: UIViewController = {
        let analyticsViewController = AnalyticsViewController()
        analyticsViewController.tabBarItem = {
            let item = UITabBarItem()
            item.image = UIImage.beskar.create(.tabIcon(.analytics))
            item.title = "ANALYTICS".localized
            return item
        }()
        return analyticsViewController
    }()

    private lazy var walletListViewController: UIViewController = {
        let walletListViewController = WalletListViewController()
        walletListViewController.tabBarItem = {
            let item = UITabBarItem()
            item.image = UIImage.beskar.create(.tabIcon(.wallets))
            item.title = "WALLETS".localized
            return item
        }()
        return walletListViewController
    }()

    private lazy var settingsViewController: UIViewController = {
        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = {
            let item = UITabBarItem()
            item.image = UIImage.beskar.create(.tabIcon(.settings))
            item.title = "SETTINGS".localized
            return item
        }()
        return settingsViewController
    }()

    // MARK: Initializer

    override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpViewControllers()
    }

    // MARK: Private Methods

    private func setUpViewControllers() {
        viewControllers = [
            analyticsViewController,
            walletListViewController,
            settingsViewController,
        ]

        selectedViewController = walletListViewController
    }
}
