//
//  Accessibility.swift
//  Beskar
//
//  Created by Igor on 06/02/2021.
//

struct A {}

extension A {
    struct WelcomeScreen {
        static let title = "WelcomeScreen.title"
        static let subtitle = "WelcomeScreen.title"
        static let disclaimer = "WelcomeScreen.disclaimer"
        static let allowButton = "WelcomeScreen.allowButton"
    }
}

extension A {
    struct ErrorScreen {
        static let title = "ErrorScreen.title"
        static let subtitle = "ErrorScreen.subtitle"
        static let image = "ErrorScreen.image"
        static let button = "ErrorScreen.button"
    }
}

extension A {
    struct LoadingScreen {
        static let spinner = "LoadingScreen.spinner"
        static let title = "LoadingScreen.title"
    }
}

extension A {
    struct WorkInProgressView {
        static let image = "WorkInProgressView.image"
        static let title = "WorkInProgressView.title"
        static let subtitle = "WorkInProgressView.subtitle"
    }
}

extension A {
    struct WalletListView {
        static let table = "WalletListView.table"
    }
}

extension A {
    struct WalletCardView {
        static let title = "WalletCardView.title"
        static let amount = "WalletCardView.amount"
        static let withdraw = "WalletCardView.withdraw"
        static let listTransactions = "WalletCardView.listTransactions"
        static let deposit = "WalletCardView.deposit"
    }
}

extension A {
    struct AddNewWalletCell {
        static let title = "AddNewWalletCell.title"
        static let subtitle = "AddNewWalletCell.subtitle"
        static let addWallet = "AddNewWalletCell.add"
    }
}
