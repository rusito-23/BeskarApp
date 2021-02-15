//
//  WalletViewModel.swift
//  Beskar
//
//  Created by Igor on 15/02/2021.
//

import BeskarKit
import Combine
import Foundation

final class WalletViewModel: ViewModel, Resolvable {

    // MARK: Properties

    @Published var wallet: Wallet?

    // MARK: Publishers

    /// The name of the wallet as a published string
    private(set) lazy var namePublisher: AnyPublisher<String?, Never> = $wallet
        .map { $0?.name }
        .eraseToAnyPublisher()

    /// The compact amount of the wallet with currency info as a published string
    private(set) lazy var compactAmountPublisher: AnyPublisher<String?, Never> =  $wallet
        .map { $0?.compactAmountFormatted }
        .eraseToAnyPublisher()
}
