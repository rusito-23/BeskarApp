import BeskarKit

final class WalletRemoveViewModel: ViewModel {

    // MARK: Properties

    var title: String { "WALLET_REMOVE_TITLE".localized }

    var subtitle: String { "WALLET_REMOVE_SUBTITLE".localized }

    var confirmTitle: String { "OK".localized }

    var cancelTitle: String { "CANCEL".localized }

    // MARK: Private Properties

    private let wallet: Wallet
    private lazy var walletService: WalletServiceProtocol = resolve()

    // MARK: Initializer

    init(wallet: Wallet) {
        self.wallet = wallet
    }

    // MARK: Methods

    func onRemovalConfirmed() {
        // TODO: Actually remove the wallet
    }
}
