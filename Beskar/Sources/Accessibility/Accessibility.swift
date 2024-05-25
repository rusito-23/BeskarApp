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
    struct WalletCardViewCell {
        static let title = "WalletCardViewCell.title"
        static let amount = "WalletCardViewCell.amount"
        static let withdraw = "WalletCardViewCell.withdraw"
        static let detailsButton = "WalletCardViewCell.detailsButton"
        static let deposit = "WalletCardViewCell.deposit"
        static let header = "WalletCardViewCell.header"
        static let separator = "WalletCardViewCell.separator"
        static let buttons = "WalletCardViewCell.buttons"
        static let content = "WalletCardViewCell.content"
    }
}

extension A {
    struct WalletListFooter {
        static let title = "WalletListFooter.title"
        static let create = "WalletListFooter.create"
    }
}

extension A {
    struct CreateWalletView {
        static let title = "CreateWalletView.title"
        static let subtitle = "CreateWalletView.subtitle"
        static let nameField = "CreateWalletView.nameField"
        static let descriptionField = "CreateWalletView.descriptionField"
        static let currencyField = "CreateWalletView.currencyField"
        static let createButton = "CreateWalletView.createButton"
    }
}

extension A {
    struct WalletActionView {
        static let title = "WalletActionView.title"
        static let amountField = "WalletActionView.amountField"
        static let saveButton = "WalletActionView.saveButton"
        static let summaryField = "WalletActionView.summaryField"
        static let disclaimer = "WalletActionView.disclaimer"
    }
}

extension A {
    struct WalletDetailView {
        static let name = "WalletDetailView.name"
        static let summary = "WalletDetailView.summary"
        static let amountHeader = "WalletDetailView.amountHeader"
        static let table = "WalletDetailView.table"
    }
}

extension A {
    struct TransactionDetailView {
        static let summary = "TransactionDetailView.summary"
        static let date = "TransactionDetailView.date"
        static let amount = "TransactionDetailView.amount"
    }
}
