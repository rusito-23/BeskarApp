//
//  BeskarViewController.swift
//  BeskarUI
//
//  Created by Igor on 29/01/2021.
//
//  Design System View Controller

import UIKit

// MARK: - BeskarViewController

open class BeskarViewController: UIViewController {

    // MARK: - View Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beskar.base
    }
}

// MARK: - BeskarTabBarController

open class BeskarTabBarController: UITabBarController {

    // MARK: - View Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.beskar.base
    }
}
