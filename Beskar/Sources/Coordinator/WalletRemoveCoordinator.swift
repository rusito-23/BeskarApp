import BeskarUI
import BeskarKit
import UIKit

final class WalletRemoveCoordinator: BaseCoordinator {

    // MARK: Coordinator Properties

    override var presented: UIViewController? { alertController }

    // MARK: Private Computed Properties

    private lazy var confirmAction = UIAlertAction(
        title: viewModel.confirmTitle,
        style: .default,
        handler: { [weak self] _ in
            guard let self else { return }
            viewModel.onRemovalConfirmed()
            stop()
        }
    )

    private lazy var cancelAction = UIAlertAction(
        title: viewModel.cancelTitle,
        style: .default,
        handler: { [weak self] _ in self?.stop() }
    )

    private lazy var alertController: UIAlertController = {
        let viewController = UIAlertController()
        viewController.modalPresentationStyle = .popover
        viewController.title = viewModel.title
        viewController.message = viewModel.subtitle
        viewController.addAction(confirmAction)
        viewController.addAction(cancelAction)
        return viewController
    }()

    // MARK: Private Properties

    private let viewModel: WalletRemoveViewModel

    // MARK: Initializer

    init(viewModel: WalletRemoveViewModel) {
        self.viewModel = viewModel
    }

    convenience init(wallet: Wallet, delegate: WalletRemoveDelegate) {
        let viewModel = WalletRemoveViewModel(wallet: wallet, delegate: delegate)
        self.init(viewModel: viewModel)
    }
}
