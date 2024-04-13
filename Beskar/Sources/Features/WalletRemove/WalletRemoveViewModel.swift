import BeskarKit

protocol WalletRemoveDelegate: AnyObject {
    func walletRemovalDidSucceed()
    func walletRemovalFailed()
}

final class WalletRemoveViewModel: ViewModel {

    // MARK: Properties

    var title: String { "WALLET_REMOVE_TITLE".localized }

    var subtitle: String { "WALLET_REMOVE_SUBTITLE".localized }

    var confirmTitle: String { "OK".localized }

    var cancelTitle: String { "CANCEL".localized }

    // MARK: Private Properties

    private let wallet: Wallet
    private lazy var walletService: WalletServiceProtocol = resolve()
    private weak var delegate: WalletRemoveDelegate?

    // MARK: Initializer

    init(wallet: Wallet, delegate: WalletRemoveDelegate? = nil) {
        self.wallet = wallet
        self.delegate = delegate
    }

    // MARK: Methods

    func onRemovalConfirmed() {
        walletService.remove(wallet) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success: delegate?.walletRemovalDidSucceed()
            case .failure: delegate?.walletRemovalFailed()
            }
        }
    }
}
