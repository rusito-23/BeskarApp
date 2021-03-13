//
//  ModalViewController.swift
//  BeskarUI
//
//  Created by Igor on 13/03/2021.
//

import UIKit
import TinyConstraints

/// Modal View Controller
///
/// # Description #
/// A View Controller that provides the ability
/// to present a view controller in a half-sheet modal.
///
/// # Notes #
/// The solution used to present a view controller that takes half of the screen
/// is to use a native `UIIActivityController`.
/// Clearly, this is not the best solution, but is a simple one...
public class ModalViewController: UIActivityViewController {

    // MARK: Properties

    private let viewController: UIViewController

    // MARK: Initializer

    public required init?(viewController: UIViewController?) {
        guard let viewController = viewController else { return nil }
        self.viewController = viewController
        super.init(activityItems: [], applicationActivities: nil)
    }

    // MARK: View Controller Overrides

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        setUpViewControllerTopBorder()
    }

    // MARK: Private Methods

    private func setUpViewController() {
        for view in view.subviews { view.removeFromSuperview() }
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.edges(to: view)
    }

    private func setUpViewControllerTopBorder() {
        viewController.view.layer.cornerRadius = Border.Radius.medium.rawValue
    }
}
